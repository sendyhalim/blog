+++
title = "Traceroute Naive Implementation Part 1: Proof of Concept"
date = 2024-01-07
description = "An attempt to implement traceroute proof of concept functionality naively in rust"

[taxonomies]
tags = ["programming", "networking-utilities"]
+++


# What we will do
Traceroute is a utility that will print packet router path (trace) and measure the delay of packets sent to a destination.
It works by sending packet probes to a destination with increasing (by 1) IP TTL/IP hop limit starting from 1,
TTL will be reduced by 1 every time the packet reaches a router. The router will discard the packet and send back an ICMP Time Exceeded error when it receives IP packet with TTL 1 because it's going to be 0 (expired).

In this post, we'll try to experiment with IP TTL as a basic component of traceroute implementation. We start with a proof of concept (PoC) implementation.
The goal is to learn by doing so expect bad error handling and bad UX.


# Key components in the PoC
Key components in our proof of concept:
* We will create a socket that listens to ICMP messages. As a starter,
  we will try to capture all ICMP packets sent to our IP and print it.
  We'll just try to see manually whether there's any ICMP Time Exceeded error sent from
  one of the routers in the path. We can try to run the `traceroute` command to the same destination (google.com) before running
  the program so we can compare the router IP at a specific hop.
* We will send the packet probe when the ICMP listener is ready,
  we'll just send 1 probe to the 6th router along the path to reach google.com since we're focusing
  only for a proof of concept, this way we know what's the router IP at the 6th hop.
* The program will only handle IPv4.
* We will not do proper error handling, we'll just print debug messages for simplicity.


We will revisit and iterate the limitations in future posts.

# Debugging
We use `tcpdump` to print out the UDP packet that we send to the destination IP,
we should be able to see the IP TTL that we set through `tcpdump`. You could use
other network packet sniffing tools such as Wireshark though.


# Implementation
<div class="image-container">
    <img
      src="{{ asset_path(path="/assets/images/traceroute-implementation/traceroute-poc.jpg") }}"
      alt="Traceroute PoC implementation overview"
    />
</div>

## Setup
#### Dependencies
I'm using rust in the example because it provides extensive low-level tooling and
I just want to have a refresher on rust, you can write the implementation using any programming language that you're comfortable with
as long as it has access to low-level socket programming.

We will install these dependencies:
* [socket2](https://github.com/rust-lang/socket2) - Utility to work with low-level networking socket.
* [etherparse](https://github.com/JulianSchmid/etherparse) - Library that provides low level network packet parsing logic (IPv4, UDP, ICMP, etc).

```
// Cargo.toml
// -----------------------
....
[dependencies]
etherparse = "0.13.0"
socket2 = { version = "0.5.5", features = ["all"] }

[lib]
name = "lib"
path = "src/lib/lib.rs"

[[bin]]
name = "traceroute-poc"
path = "src/bin/traceroute_poc.rs"
```

#### Directory structure
Our directory structure will look like this

```
├── Cargo.lock
├── Cargo.toml
├── rustfmt.toml // Cosmetics, configuration for code formatting
└── src
    ├── bin // Runnables
    │   ├── ....
    │   └── traceroute_poc.rs
    └── lib // Reusable functions
        ├── icmp_listener.rs
        └── lib.rs
```


## ICMP listener
#### Create an ICMP socket
There will be  a function to start an ICMP listener,
it's basically creating a socket that we can use to capture the incoming messages later on.


```
// src/lib/icmp_listener.rs
// ------------------------------
use socket2::{Domain, Socket};
use std::mem::MaybeUninit;
use std::time::Duration;

pub fn start_icmp_listener() {
  let icmp_socket = Socket::new(
    Domain::IPV4,
    socket2::Type::RAW,
    Some(socket2::Protocol::ICMPV4),
  )
  .unwrap();

  icmp_socket
    .set_read_timeout(Some(Duration::from_secs(1)))
    .unwrap();

  ... will be continued
}
```


#### Capturing ICMP packets
We need to prepare the ICMP response placeholder first, the ICMP response will include IPv4 so we will need
28 bytes considering the minimum [IPv4 header](https://en.wikipedia.org/wiki/Internet_Protocol_version_4#Packet_structure) is 20 bytes and all ICMP packets have an [8-byte header](https://en.wikipedia.org/wiki/Internet_Control_Message_Protocol#Datagram_structure).

Then we initiate an infinite loop and short polling to the ICMP socket by calling `icmp_socket.recv_from(..)`,
the method will block until there's a response or it's reaching 1 second -- the read timeout that we set earlier.
On every incoming packet, we use etherparse to parse bytes into an IPv4 header and assume the rest of the unused bytes to be ICMP payload.

```
// src/lib/icmp_listener.rs
// ------------------------------
pub fn start_icmp_listener() {
  ... create icmp socket
  ...

  let mut icmp_resp: [MaybeUninit<u8>; 28] = unsafe { MaybeUninit::uninit().assume_init() };

  loop {
    match icmp_socket.recv_from(&mut icmp_resp) {
      Ok((size, addr)) => {
        let resp_bytes = icmp_resp
          .into_iter()
          .map(|byte| unsafe { byte.assume_init() })
          .collect::<Vec<u8>>();

        let (ipv4_header, icmpv4_payload_bytes) =
          etherparse::Ipv4Header::from_slice(&resp_bytes).unwrap();
        let icmpv4_payload = etherparse::Icmpv4Slice::from_slice(icmpv4_payload_bytes).unwrap();

        println!(
            "Got some response size: {}\nipv4 raw resp: {:?}\nip address:{}\nICMP type: {:?}, ICMP code: {}",
            size,
            ipv4_header,
            addr.as_socket_ipv4().unwrap().to_string(),
            icmpv4_payload.icmp_type(),
            icmpv4_payload.code_u8()
          );
      }
      Err(err) => {
        println!("Error when waiting for icmp socket {:?}", err);
      }
    }
  }
}
```


## Send a UDP probe
Next, we go to the main function. Let's just assume we want to know the router at 6th hop going to `google.com`,
we use [`ToSocketAddrs`](https://doc.rust-lang.org/std/net/trait.ToSocketAddrs.html#tymethod.to_socket_addrs) trait that gives us the extra capability to convert the domain name to IP address (it will do DNS lookup in the background).

```
// src/bin/traceroute_poc.rs
// ------------------------------
use std::net::{SocketAddr, ToSocketAddrs, UdpSocket};

fn main() -> std::io::Result<()> {
  // Preparing the IPv4 UDP socket
  // ----------------------------------------
  let udp_socket_client_port: u16 = 33474;
  let udp_socket_dest_port: u16 = 33475;
  let udp_socket_addr_client: SocketAddr = format!("0.0.0.0:{}", udp_socket_client_port)
    .parse()
    .unwrap();

  let udp_socket_addr_dest: SocketAddr = ("google.com", udp_socket_dest_port)
    .to_socket_addrs() // It will do dnslookup in the background
    .unwrap()
    .into_iter()
    .filter(|socket_addr: &SocketAddr| {
      return socket_addr.is_ipv4();
    })
    .collect::<Vec<_>>()
    .first()
    .unwrap()
    .to_owned();

  let udp_socket: UdpSocket;
  let hop_limit: u32 = 6;

  udp_socket = UdpSocket::bind(udp_socket_addr_client).unwrap();
  udp_socket.set_ttl(hop_limit).unwrap();


  // Start the icmp listener before sending the UDP probe
  // ----------------------------------------
  let icmp_listener_handle = std::thread::spawn(|| {
    println!("Starting icmp listener in the background...");

    lib::icmp_listener::start_icmp_listener();
  });


  // Sending the UDP probe
  // ----------------------------------------
  let udp_payload: [u8; 2] = [0, 0]; // Dummy payload

  println!("Sending {:?} to {:?}", udp_payload, udp_socket_addr_dest);
let sent_count = udp_socket
    .send_to(&udp_payload, udp_socket_addr_dest)
    .unwrap();

  println!("Sent {} bytes of payload", sent_count);

  // Block icmp listener thread.
  // ----------------------------------------
  icmp_listener_handle.join().unwrap();

  return Ok(());
}
```

### Testing it out
We'll start a `tcpdump` to sniff the IP packet that we send, we should expect
the right IP address and IP TTL to be 6 (hardcoded earlier).

```
sudo tcpdump udp port 33474 -n -vvv
```

Now build and run the program
```
cargo build && sudo RUST_BACKTRACE=1 ./target/debug/traceroute_poc
```
From the tcpdump you should see something like this
```
# Notice that IP ttl is set to 6, that's a good sign!
# ---------------------
tcpdump: data link type PKTAP
tcpdump: listening on pktap, link-type PKTAP, capture size 262144 bytes
23:01:44.812806 IP (tos 0x0, ttl 6, id 28731, offset 0, flags [none], proto UDP (17), length 30)
    192.168.1.6.33474 > 216.239.38.120.33475: [udp sum ok] UDP, length 2
```

The sample program output
```
Sending [0, 0] to 216.239.38.120:33475
Starting icmp listener in the background...
Sent 2 bytes of payload
Got some response size: 28
IPv4 raw resp: Ipv4Header { ihl: 5, differentiated_services_code_point: 0, explicit_congestion_notification: 0, payload_len: 19436, identification: 59500, dont_fragment: false, more_fragments: false, fragments_offset: 0, time_to_live: 249, protocol: 1, header_checksum: 38208, source: [180, 240, 205, 80], destination: [192, 168, 1, 6], options: [] }
ip address:180.240.205.80:0
ICMP type: TimeExceeded(TtlExceededInTransit), ICMP code: 0
```

We can compare it by running traceroute and checking whether the router at the 6th hop has the same router IP that we have captured (output above). It's normal that the packet path is different from time to time routing might change dynamically as well.
```
traceroute google.com
```

You can find the implementation in this post [here](https://github.com/sendyhalim/network-utilities/blob/master/src/bin/traceroute-poc.rs).

# What's next
In this post we have completed the PoC and see it ourselves that when IP packet TTL is 1 then the router will send ICMP Time Exceeded error to our IP. In the next post we will try to send multiple UDP probes and print them out.
