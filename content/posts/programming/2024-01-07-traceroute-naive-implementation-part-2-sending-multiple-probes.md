+++
title = "Traceroute Naive Implementation Part 2: Sending Multiple Probes"
date = 2024-01-10
description = "An attempt to implement traceroute proof of concept functionality naively in rust"
draft = true

[taxonomies]
tags = ["programming", "networking-utilities"]
+++


# What we will do
This time we'll build on top of the previous traceroute PoC, this time we will
implement functionality to send multiple probes and print the router IP (if they send us back the ICMP TimeExceeded error),
we will not measure round-trip delay yet to keep things simple.

# Raw Socket
First we'll rewrite our udp socket to use raw socket instead, this will give us
more flexibility to build raw IPv4 header, just in case we need to add flags or any other
IPv4 header value.

# Sending multiple probes
1. We'll prepare an array placeholder that will be filled with UDP payload.
2. We'll iterate each UDP payload sequentially and send the probe, we'll wait for an ICMP message before sending each payload.

# Iterating through TTL and send multiple probes

