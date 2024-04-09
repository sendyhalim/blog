+++
title = "War Story: Accidentally Ran A Database Update Without Where Clause"
date = 2023-09-30
description = "A personal experience where I accidentally ran a database update without where clause"

[taxonomies]
tags = ["software-engineering", "day-to-day", "best-practices", "war-stories"]
+++

## What Happened
Back in 2019 I was in a very good mood that the product launch was quite smooth in the past months.
I got report that there were calculation bugs affecting some of the data. The bug was reproducible locally, I skimmed at the code and just kind of knew where the miscalculation happened in the code,
my confident was high and my coffee tasted good on that day!

Long story short, I submitted the bug fix to be reviewed and then deployed
the fix to our testing environment. I tested it manually in concurrent to the QA testing process, the fix worked
well on test environment and I deployed it directly to the prod, the fix was confirmed to work on production as well,
I could see incoming data was calculated correctly.

As the finisher, I move forward to update the old data that was incorrect prior the fix.
I was already in the company network, so I connected to the database through psql
and start writing the update statement. I couldn't remember what was going on in my mind but
I typed the closing semicolon as soon as I reached the update statement, I had not typed the filter, it was the
worst thing that could happen.
```
update a_table set x = x * 1.1; -- <enter>
```

I didn't even notice, looking at my sql statement that I ran, it was kind of hanging there on psql 🤨. It's just like your typical query when it's processing a lot of data then
it returned the updated rows, showing tens of thousands of data had been updated, this was a small DB, but still tens of thousands is a lot to
fix.

Thankfully I was able to pull a quick sql to update all the data again, I was lucky that I applied DML that's easy to reverse.
```
update a_table set x = x / 1.1; -- <enter>
```

Putting cherry on the top, there was no new data coming in. The query worked and
I can still keep my job, also big thanks to my coffee that I made for myself.
Completing the day, I wrote the query with the filter (where clause) first then the DML to complete the day
with a very good lesson that I keep up until now.


## What Went Wrong and Lesson Learned
For reflection, here are the list that could've been done better:
* Data update should run in a database transaction so we can rollback in case unexpected things happen, in my case it should be possible because we're using Postgres.
* It's not gonna hurt to ask peers to review the SQL statement before running it.
* Test the SQL query in local machine or in testing environment.
* If for whatever reason we need to write the SQL statement directly in production then it's a lot safer to filter/where statement first.
