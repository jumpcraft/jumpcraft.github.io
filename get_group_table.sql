select
	g.groupname as 'Team Name',
    coalesce(a.num, 0) as 'Achievement Count',
    coalesce(a.num, 0) / pc.player_count as Points
from (select distinct groupname from user_group) as g
left join (
	select count(*) as num, groupname
	from user_achievement
	inner join user_ids on
		user_achievement.id = user_ids.id
	inner join user_group on
		user_ids.username = user_group.username
	where
		done = 1
		and achievement like 'blaze%'
	group by groupname
) as a on
	g.groupname = a.groupname
inner join (
	select groupname, count(1) as player_count
	from user_group
	group by groupname
) as pc on
	g.groupname = pc.groupname
order by Points desc;
