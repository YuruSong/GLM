--------------
Jan 14 2020
--------------
Bout triggered average. Check all the features prior to the initiation of 'chase' and 'search' behaviors.

--------------
Jan 13 2020
--------------
Trying GLM on binary output, i.e. search or not, chase or not. 

About behavior bout, how to select them? First, look at the time length distribution of these two behaviors. Run MATLAB program `plot_behav_length_stat.m`, dependent on `behav_length_stat.m` and `plot_areaerrorbar.m`.

Shown in the following figure, the second group (WT/Or47b Light) data seems weird in the search behavior. There are lots of short duration behaviors (just like bread crumbs insteads of slices of breads). Hard to understand the reason. 

![](behav_length_stat.jpg)

Back to the bout selection, if the 'chase' lasts longer than 0.5s (I determine it arbitrarily, based on the distribution), then count it as a 'chase' bout. Next step: bout triggered average for the 'chase' bouts.

--------------
Jan 07 2020
--------------

1. Behavior selection, do we need all the chase/search behavior?

2. Feature selection, primarily focus 'mfDist', add more features if necessary, for example if the 'mfDist' is noisy being an olfactory proxy, consider further description of female movement as the odor source 

3. GLM first, simple things first.

4. Use lab machine, not mine. Establish the remote access.


--------------
Jan 06 2020
--------------
After many lessons from previous experience, I decided to take detailed record of coding/analysis during a project. Let's see if this will make a difference!
