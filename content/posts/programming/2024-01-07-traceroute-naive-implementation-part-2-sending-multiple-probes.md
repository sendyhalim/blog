+++
title = "Traceroute Naive Implementation Part 2: Sending Multiple Probes"
date = 2024-01-10
description = "An attempt to implement traceroute proof of concept functionality naively in rust"
draft = true

[taxonomies]
tags = ["programming", "networking-utilities"]
+++


# What we will do
We'll build on top of the previous traceroute PoC(TODO: Set link), this time we will
implement functionality to send multiple probes and print the router IP (if they send us back the ICMP TimeExceeded error),
we will not measure round-trip delay yet to keep things simple.

Step by step explanation:
1. We will set max TTL / hop limit to 30
2. We'll prepare an array filled with 3 placeholder that will be filled with UDP payload for every iteration of TTL starting from 1 - 30, so we would send at most 30 * 3 ud probes.
3. For every TTL, we'll send each of the probe sequentially. We'll wait for an ICMP message before sending the next probe,
   if we receive ICMP Time Exceeded error then we'll printout the sender (router) IP, if we do not receive it up until 5 seconds then we'll print `*` and continue the iteration

# Using Raw Socket
First we'll rewrite our UDP socket to use raw socket instead, this will give us
more flexibility to build raw IPv4 header if we need to add flags or any other
IPv4 header value. The tradeoff is we need to construct the IPv4 header and UDP header manually.

....
### Initiating Raw Socket
We use `UdpSocket` in our previous implementation, we replace `UdpSocket` with `socket2::Socket` to
allow us to use raw socket, internally it will create a system socket with `SOCK_RAW` type.

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


### Preparing the header and payload
We will need to construct the IP header and payload (include UDP header and payload as well) on our own because we're using a raw socket.
Several keypoints in this section
* We're still using the dummy UDP payload
* We need to create UDP header without the ipv4 checksum (pseudo)
* TODO: read more about dont_fragment flag... We set IP flag dont_fragment to true explicitly because if IP needs to fragment (depends on router's MTU) payload then it will not be reassambled until it reaches final destination which
* We need to create IPv4 header and then append all UDP header + payload as IPv4 payload, it's depicted in the diagram below

```
# Create UDP header
# ---------------------
let udp_payload: [u8; 2] = [0, 0];
let udp_header = etherparse::UdpHeader::without_ipv4_checksum(
  udp_socket_client_port,
  udp_socket_dest_port,
  udp_payload.len(), // Later will be sum-med with udp_header len
)
.unwrap();

let mut udp_packet: Vec<u8> = vec![];
udp_packet.extend_from_slice(&udp_header.to_bytes());
udp_packet.extend_from_slice(&udp_payload);

# Create IPv4 header
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

ipv4_header.dont_fragment = false;

// If set to true then `send` method will expect us to include IPv4 header
// in the payload.
ip_raw_socket.set_header_included(true).unwrap();

// Construct raw ip payload
let mut raw_ip_payload: Vec<u8> = vec![];

ipv4_header.write(&mut raw_ip_payload).unwrap();
raw_ip_payload.extend_from_slice(&udp_packet);
```


# Preparing IP TTL value and placeholder for probes




# Iterating through TTL




# Send the probes and print the result

