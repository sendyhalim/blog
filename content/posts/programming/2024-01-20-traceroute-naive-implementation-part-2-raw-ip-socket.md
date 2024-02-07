+++
title = "Traceroute Naive Implementation Part 2: Raw IP Socket"
date = 2024-01-20
description = "An attempt to implement traceroute proof of concept functionality naively in rust part 2"
weight = 2

[taxonomies]
tags = ["programming", "networking-utilities", "traceroute-implementation"]
+++


We'll build on top of our [traceroute PoC](/posts/programming/traceroute-naive-implementation-part-1-proof-of-concept/),
this time we will rewrite our UDP socket to use raw socket instead. Using raw IP socket will give us
more flexibility to build raw IPv4 header just in case we need to add flags or any other
IPv4 header value. The tradeoff is we need to construct the IPv4 header and then fill the IPv4 payload with a UDP header and payload manually.

# Initiating Raw Socket
We use `UdpSocket` in our previous implementation, we replace `UdpSocket` with `socket2::Socket` to
allow us to use raw socket where internally it will create a system socket with `SOCK_RAW` type.

```
## Before
## ------------
udp_socket = UdpSocket::bind(udp_socket_addr_client).unwrap();


## After
## ------------
let ip_raw_socket = Socket::new(
  Domain::IPV4,
  socket2::Type::RAW,
  Some(socket2::Protocol::UDP),
)
.unwrap();
```


# Preparing the header and payload
The consequence of using a raw socket is we need to construct the IP header and payload (contains UDP header and payload as well) on our own in exchange for flexibility,
there are several key points in preparing the IP header and payload in this section:
* We're still using a dummy UDP payload.
* We need to construct a UDP header and payload first, the UDP header and payload will be part of the IP payload.
* Then we construct an IPv4 header then append the UDP header and UDP payload as IP payload, it's depicted in the diagram below.

<div class="image-container">
    <img
      src="{{ asset_path(path="/assets/images/traceroute-implementation/ip-datagram.jpg") }}"
      alt="IP Datagram containing UDP header and payload"
    />
</div>



```
# Construct UDP header and payload
# ---------------------
let udp_header = etherparse::UdpHeader::without_ipv4_checksum(
  udp_socket_client_port,
  udp_socket_dest_port,
  udp_payload.len(), // Later will be sum-med with udp_header len
)
.unwrap();

let udp_payload: [u8; 2] = [0, 0];

let mut udp_packet: Vec<u8> = vec![];
udp_packet.extend_from_slice(&udp_header.to_bytes());
udp_packet.extend_from_slice(&udp_payload);

# Construct IP header
# ---------------------
let ipv4_addr: Ipv4Addr = udp_socket_addr_dest.ip().to_string().parse().unwrap();
let mut ipv4_header = etherparse::Ipv4Header::new(
  udp_packet.len() as u16, // IP Payload length, IP payload will contain the whole UDP packet (header and payload)
  hop_limit as u8,
  17, // UDP protocol
  udp_socket_addr_client
    .ip()
    .to_string()
    .parse::<Ipv4Addr>()
    .unwrap()
    .octets(), // Source IP
  ipv4_addr.octets(), // Destination IP
);

// The default value is true inside etherparse::Ipv4Header::new() method.
// The DF bit is not set when observing traceroute
// through tcpdump, so we're just mimicking the behavior here.
ipv4_header.dont_fragment = false;

// If set to true then `send` method will expect us to include an IP header
// in the data that we pass into send_to method
ip_raw_socket.set_header_included(true).unwrap();

// Construct IP datagram
# ---------------------
let mut ip_datagram: Vec<u8> = vec![];

ipv4_header.write(&mut ip_datagram).unwrap();
ip_datagram.extend_from_slice(&udp_packet);
```
# Build and test
The complete code can be found on my [github](https://github.com/sendyhalim/network-utilities/blob/traceroute-part-2-raw-socket/src/bin/traceroute_poc_raw_socket.rs).

```
# Start tcpdump first to sniff our packet
# ----------------------------------------
sudo tcpdump udp port 33474 -n -vvv

# Build and run
# ----------------------------------------
cargo build && sudo RUST_BACKTRACE=1 ./target/debug/traceroute_poc_raw_socket

... The rest are the same as in part 1
```

# What's next
In the next post, we will try to send multiple UDP probes and print responding router IPs.
