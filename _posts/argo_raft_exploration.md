---
title: "Argo: An exploration of the Raft protocol"
permalink: "/argo-raft-exploration"
date: "~N[2023-11-15 19:00:00]"
layout: "Clark.Layouts.PostLayout"
---

I (sort of) implemented Raft. If you just want to check that out, it's [here](https://github.com/clark-lindsay/argo/tree/main). What follows is why and how I ended up doing that, and some opinions on how to build understanding.

## Wait, I know that name

A few weeks ago I saw a [lecture video](https://www.youtube.com/watch?v=vYp4LYbnnW8) pop up in my YouTube recommendations (yes, I'm serious -- I watch a lot of conference talks there) about the [Raft consensus algorithm](https://raft.github.io/). I might have scrolled past it after my experience trying to grok [Paxos](https://en.wikipedia.org/wiki/Paxos_(computer_science)), but I did a double take when I saw that the lecturer was [John Ousterhout](https://web.stanford.edu/~ouster/cgi-bin/home.php), whose book [A Philosophy of Software Design](https://web.stanford.edu/~ouster/cgi-bin/aposd.php) was very impactful on my views of, er, software design. I highly recommend it.

So I click into the video and start watching it and I quickly realize that Ousterhout is one of the co-authors of Raft alongside his PhD student [Diego Ongaro](https://ongardie.net/). Not sure how I hadn't made that connection before, but it helps that I had never read the paper. Well, now I'm invested. I had heard of the protocol and had seen enough buzz about it to know that it was _neat_, but I hadn't looked into it because I tend to build up massive lists of technical topics that I usually prioritize incorrectly. I think I'm getting better at that. I hope, anyway.

## From scratch, ish

After watching the video and walking away with some rudimentary mental model of the idea(s) in my head I jumped over to their site and read [the paper itself](https://raft.github.io/raft.pdf), and found it very digestible and clear compared to other CS papers I've read. Sure, it has a couple of important details about a practical implementation pretty late into the paper (looking at you, Section 8) but it's all there.

I decided that it would be very instructive, and maybe even a bit fun, to implement the whole thing in my favorite language: [elixir](https://elixir-lang.org/). The [BEAM](https://www.erlang.org/blog/a-brief-beam-primer/) has quite the pedigree for building distributed systems, and would supply me with brilliant building blocks for an _exploratory_ implementation of the algorithm.

Before I got going I outlined my goals and some limitations:

- above all, I'm doing this to grok the algorithm, and to have some fun
- I'm okay ignoring distributed nodes, and instead modeling that separation with message passing between BEAM processes
- I want to base my implementation solely on the paper, and the lecture video, without referencing one of the many [implementations](https://raft.github.io/#implementations) that are open sourced
   - shoutout to the ***much more complete*** [implementation by my friend Chris Keathley](https://github.com/elixir-toniq/raft)
- I'm alright not writing the log(s) out to non-volatile storage
   - this defeats the real purpose of the algorithm, but adding it wouldn't hugely increase my understanding of what's going on

### moving the bits around

As of this writing, I've spent an average of a few hours (maybe 3?) per day for the last 2 weeks working on this, which was a lot of reading and notebook diagrams followed by short bursts of programming, and I've reached a point of happiness with it. In the back-half of this process I could notice bugs or continue building new pieces without reaching for the paper again, which served as good feedback that I was really "getting it". Particularly when a subsequent peek at the paper didn't reveal that I had confidently written a new bug, which also happened.

**Great** credit is due to the authors of the algorithm for going out of their way to design an understandable algorithm, and for producing excellent reference material.

I named my _implementation_ (rather generous use of the word, frankly) "Argo", after [the ship of Greek myth](https://en.wikipedia.org/wiki/Argo), and you can check it out [on github](https://github.com/clark-lindsay/argo/tree/main). I figured that the Argo would make an excellent "raft" to sail away from Paxos.

## Well, does it work?

For a certain definition of the word "work", yes! I've cut a number of corners, sure, but I can spin up a local cluster of processes and kill them off at random and they'll elect a new leader, replicate their logs, and keep serving requests as long as a majority of the server processes are still up.

More importantly, I got to dig into the algorithm and get a feel for why each piece of it is there, and how the design choices that the Raft research team made avoided more complicated mechanisms and produced relatively few edge cases. I feel like I really _get it_ now, and I attribute that largely to taking the time to build the thing from scratch (-ish*, since I had brilliant reference material and leaned massively on the BEAM and standard elixir tools).

## What I've learned

For one thing: how Raft works. That's the big box: _checked_. But I also learned, or really _re-proved to myself_, the value of building understanding from first principles and practice. Writing out and testing the logic for something like Raft's "heartbeats", even with the aforementioned corner-cutting, is a huge leap in understanding from my first read of the paper, despite the highlighter in my hand that assured me that I signalled the important pieces to my brain. 

Got to write some OTP and some property-based testing on the way too, and that's always satisfying.

Now I think I'm moving on to learning more about event streaming and messages queues, à la [kafka](https://kafka.apache.org/#:~:text=Apache%20Kafka%20is%20an%20open,%2C%20and%20mission%2Dcritical%20applications.) and [RabbitMQ](https://www.rabbitmq.com/), plus I've got to prep for D&D. 

