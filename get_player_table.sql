select 
	username as Username,
    coalesce(a.num, 0) as 'Achievement Count',
    coalesce(a.num, 0) / (user_stat.value/(20*60*60)) as 'Achievements/hr'
from user_ids
left join (
	select count(*) as num, id
	from user_achievement
    where
		done = 1
        and achievement like 'blaze%'
	group by id
) as a on
	user_ids.id = a.id
inner join user_stat ON
	user_ids.id = user_stat.id
	and user_stat.stat = 'minecraft:play_one_minute'
where a.num is not null
order by a.num DESC, username ASC;