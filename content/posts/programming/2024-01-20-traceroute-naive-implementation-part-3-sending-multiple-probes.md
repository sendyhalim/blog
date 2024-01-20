+++
title = "Traceroute Naive Implementation Part 3: Sending Multiple Probes"
date = 2024-01-20
description = "An attempt to implement traceroute proof of concept functionality naively in rust "
draft = true
weight = 3

[taxonomies]
tags = ["programming", "networking-utilities", "traceroute-implementation"]
+++


# What we will do
We'll build on top of our [traceroute PoC part 2](/posts/programming/traceroute-naive-implementation-part-1-proof-of-concept/),

we will not measure round-trip delay yet to keep things simple.

implement functionality to send multiple probes and print the router IP (if they send us back the ICMP TimeExceeded error),
Step by step explanation:
1. We will set max TTL / hop limit to 30
2. We'll prepare an array filled with 3 placeholder that will be filled with UDP payload for every iteration of TTL starting from 1 - 30, so we would send at most 30 * 3 ud probes.
3. For every TTL, we'll send each of the probe sequentially. We'll wait for an ICMP message before sending the next probe,
   if we receive ICMP Time Exceeded error then we'll printout the sender (router) IP, if we do not receive it up until 5 seconds then we'll print `*` and continue the iteration


# Preparing IP TTL value and placeholder for probes




# Iterating through TTL




# Send the probes and print the result

