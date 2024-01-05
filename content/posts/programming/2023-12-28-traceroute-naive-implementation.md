+++
title = "Traceroute Naive Implementation: Part 1 - Proof of Concept"
date = 2023-12-28
description = "An attempt to reimplement traceroute functionality naively in rust"
draft = true

[taxonomies]
tags = ["programming", "networking-utilities"]
+++


# What will we do
Traceroute is a utility that will print trace path and measured delay of packets sent to a destination.
It works by sending packet probes to a destination with increasing (by 1) IP TTL/IP hop limit starting from 1,
hop limit will be decreased by 1 everytime the packet reach a router and the router _would_ send back an ICMP Time Exceeded error when the IP hop limit reaches 0.

In this post we'll try to go cover basic key components of traceroute implementation and try to implement the
proof of concept from the key components. The goal of the post is to learn by doing so expect bad error handling and bad UX.


# Key components
## Implementation
There are 2 key components in the implementation:
1. There's a socket connection to listen to ICMP message.
  * We will expect ICMP Time Exceeded error specifically sent to our process, the ICMP message
       will be sent to us from the router that receives packet with TTL/hop limit reaching 0.
  * We wil print the sender socket address (IP address) and estimate the packet round-trip
    time for every ICMP Time Exceeded error that we receive.
2. After the listener is ready we will send packet probes, ther eare 3 packet probes starting with hop limit 1
   then incrementally sending the probes again up until 64 hop limit.


## Debugging
We'll use `tcpdump` to printout the UDP packet that we send to the destination IP,
we should be able to see the IP TTL that we set through `tcpdump`. You could use
other network packet sniffing tool such as wireshark though.

# Implementation


