+++
title = "Postgres Reading Checklist"
date = 2023-09-10
description = "This is my compilation of postgres reading checklist"

[taxonomies]
tags = ["database", "reading-checklist"]
+++

I'm not a database expert, in my career I've faced so many issues and bottlenecks,
most of the come from database. My crystal ball 🔮 told me that it's just a matter of time
until the next database issues occur, so I decided to gather as much practical
database learning sources as I can in the past years, especially the ones that I think (based on experience)
will most likely be used.

We're using postgres at work so it's going to be tailored specifically to it,
the checklist should be read in order but nothing stops you to jump around.

## Basic Postgres
* [Discovering the Computer Science Behind Postgres Indexes](http://patshaughnessy.net/2014/11/11/discovering-the-computer-science-behind-postgres-indexes)
* [Following a Select Statement Through Postgres Internals](http://patshaughnessy.net/2014/10/13/following-a-select-statement-through-postgres-internals)
* [A Look at How Postgres Executes a Tiny Join](http://patshaughnessy.net/2015/11/24/a-look-at-how-postgres-executes-a-tiny-join)
* [Is Your Postgres Query Starved for Memory?](http://patshaughnessy.net/2016/1/22/is-your-postgres-query-starved-for-memory)
* [Understanding `bitmap heap scan` and `bitmap index scan`](https://dba.stackexchange.com/a/119391)
* [Understanding bitmap indexes in postgresql](https://stackoverflow.com/questions/33100637/understanding-bitmap-indexes-in-postgresql)

## Slow Queries
* [Reading a Postgres `EXPLAIN ANALYZE` Query Plan](https://thoughtbot.com/blog/reading-an-explain-analyze-query-plan)
* [How to Interpret PostgreSQL `EXPLAIN ANALYZE` Output](https://www.cybertec-postgresql.com/en/how-to-interpret-postgresql-explain-analyze-output/)
* [3 Ways to Detect Slow Queries in PostgreSQL](https://www.cybertec-postgresql.com/en/3-ways-to-detect-slow-queries-in-postgresql/)

## Postgres Locks
* [PostgreSQL rocks, except when it blocks: Understanding locks](https://www.citusdata.com/blog/2018/02/15/when-postgresql-blocks/)

## Replication
* [Replication Solutions](https://www.postgresql.org/docs/current/different-replication-solutions.html)
* [Logical Replication](https://www.postgresql.org/docs/current/logical-replication.html)

## Other References
Not related directly to postgres, more of a general knowledge:
* [Operating system concepts](https://www.amazon.com/Operating-System-Concepts-Abraham-Silberschatz/dp/1119800366/ref=zg_bs_g_3863_sccl_4/134-5812815-2007334?psc=1)
* [Understanding disk IO](https://scoutapm.com/blog/understanding-disk-i-o-when-should-you-be-worried)


