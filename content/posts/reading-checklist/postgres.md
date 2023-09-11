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

## Tuning postgres
* [On the impact of full-page writes](https://web.archive.org/web/20230615074135/https://www.2ndquadrant.com/en/blog/on-the-impact-of-full-page-writes/)
* [Basics of Tuning Checkpoints](https://web.archive.org/web/20221008035823/https://www.enterprisedb.com/blog/basics-tuning-checkpoints)
* [Tuning PostgreSQL for High Write Workloads](https://www.youtube.com/watch?v=xrMbzHdPLKM)
* [Full text search (psql 12)](https://www.youtube.com/watch?v=c8IrUHV70KQ)

## Data Partitioning
As of this writing, there are some changes in data partitioning on different version of postgres, so please
always refer back to the official postgres documentation.
* [How to use table partitioning to scale PostgreSQL](https://web.archive.org/web/20230324101619/https://www.enterprisedb.com/postgres-tutorials/how-use-table-partitioning-scale-postgresql)
* [Automatic Partition Creation in PostgreSQL](https://web.archive.org/web/20230528084934/https://www.cybertec-postgresql.com/en/automatic-partition-creation-in-postgresql/)
* [PostgreSQL 14: Automatic hash and list partitioning?](https://web.archive.org/web/20221201065013/https://www.dbi-services.com/blog/postgresql-14-automatic-hash-and-list-partitioning/)


## Replication
Replication is a method to do data redundancy, there are several reasons why you want to have redundancy:
1. Having a live replica in different location as a backup just incase the primary DB is down. There might be regulatory needs for data redundancy.
2. Offload data ingestion workload to another database.

Checklist:
* [Replication Solutions](https://www.postgresql.org/docs/current/different-replication-solutions.html)
* [Logical Replication](https://www.postgresql.org/docs/current/logical-replication.html)

## Other References
Not related directly to postgres, more of a general knowledge:
* [Operating system concepts](https://www.amazon.com/Operating-System-Concepts-Abraham-Silberschatz/dp/1119800366/ref=zg_bs_g_3863_sccl_4/134-5812815-2007334?psc=1)
* [Understanding disk IO](https://scoutapm.com/blog/understanding-disk-i-o-when-should-you-be-worried)


