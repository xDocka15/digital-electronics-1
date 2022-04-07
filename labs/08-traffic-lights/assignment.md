Skip to content
Search or jump to…
Pull requests
Issues
Marketplace
Explore
 
@xDocka15 
tomas-fryza
/
digital-electronics-1
Public
Code
Issues
Pull requests
Actions
Projects
Wiki
Security
Insights
You’re making changes in a project you don’t have write access to. Submitting a change will write it to a new branch in your fork xDocka15/digital-electronics-2, so you can send a pull request.
digital-electronics-1
/
labs
/
08-traffic_lights
/
assignment.md
in
tomas-fryza:master
 

Spaces

3

Soft wrap
1
# Lab 8: YOUR_FIRSTNAME LASTNAME
2
​
3
### Traffic light controller
4
​
5
1. Figure of traffic light controller state diagram. The image can be drawn on a computer or by hand. Always name all states, transitions, and input signals!
6
​
7
   ![your figure]()
8
​
9
2. Listing of VHDL code of the completed process `p_traffic_fsm`. Always use syntax highlighting, meaningful comments, and follow VHDL guidelines:
10
​
11
```vhdl
12
    --------------------------------------------------------
13
    -- p_traffic_fsm:
14
    -- The sequential process with synchronous reset and 
15
    -- clock_enable entirely controls the s_state signal by 
16
    -- CASE statement.
17
    --------------------------------------------------------
18
    p_traffic_fsm : process(clk)
19
    begin
20
        if rising_edge(clk) then
21
            if (reset = '1') then   -- Synchronous reset
22
                s_state <= STOP1;   -- Set initial state
23
                s_cnt   <= c_ZERO;  -- Clear delay counter
24
​
25
            elsif (s_en = '1') then
26
                -- Every 250 ms, CASE checks the value of the s_state 
27
                -- variable and changes to the next state according 
28
                -- to the delay value.
29
                case s_state is
30
​
31
                    -- If the current state is STOP1, then wait 1 sec
32
                    -- and move to the next GO_WAIT state.
33
                    when STOP1 =>
34
                        -- Count up to c_DELAY_1SEC
35
                        if (s_cnt < c_DELAY_1SEC) then
36
                            s_cnt <= s_cnt + 1;
37
                        else
38
                            -- Move to the next state
39
                            s_state <= WEST_GO;
40
                            -- Reset local counter value
41
                            s_cnt <= c_ZERO;
42
                        end if;
43
​
44
                    when WEST_GO =>
45
                        -- WRITE OTHER STATES HERE
No file chosen
Attach files by dragging & dropping, selecting or pasting them.
@xDocka15
Propose changes
Commit summary
Create assignment.md
Optional extended description
Add an optional extended description…
 
© 2022 GitHub, Inc.
Terms
Privacy
Security
Status
Docs
Contact GitHub
Pricing
API
Training
Blog
About
