select username, coalesce(a.num, 0) as achievements
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
order by achievements DESC;