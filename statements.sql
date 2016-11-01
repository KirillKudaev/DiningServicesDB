/*
* 1.
* 2 list all ratings for a certain dish on a certain day
* 3 check which dishes are vegitarian on a certain day
* 4 display all dishes that ever received a score under 2
* 5 display when dining room is open for lunch on saturday
* 6 display how late the grill is open at the pub on Friday
* 7 display the menu for an upcoming meal on certain date
* 8 display all comments about all dishes for a certain meal
* 9 show all comments made on a certain day
* 10 display all comments by a certain user
* 11 display average rating for vegan dishes
* 12 display pub hours for next week
*/

/*1. See who is currently checked in at the pub
* People who have checked in will be deleted from
* the database after one hour. So, anyone in the table
* will be checked in.
*/
select firstName, lastName from User u
where u.id in (select userId from CheckIn
  where locationId = 2)
order by lastName, firstName;

/*2. List all ratings for a certain dish on a certain day
*/
select d.name, r.score from Rating r
join Dish d on d.id = r.dishId
where d.name = "Salmon"
  and date = '2016-10-01'
order by r.score;

/*3. List all vegitarian dishes on a certain day*/
select d.name from Dish d
join Menu m on m.dishId = d.id
where m.date = '2016-10-1' and d.FoodTypeId = 2
order by d.name;

/*4. display all dishes that ever received a score 2 under*/
select d.name from Dish d
join Rating r on r.dishId = d.id
where r.score <= 2
order by d.name;



/*11. display average rating for vegan dishes*/
select avg(score) as 'Average Rating' from Rating r
join Dish d on r.dishId = d.id
join FoodType f on f.id = d.FoodTypeId
where f.type = 'Vegitarian';

/*12. display pub hours for Friday and Saturday
* Overall pub hours doesn't include pub grill
*/
select dayOfWeek, timeOpens, timeCloses from OperationHours o
join Institution i on i.id = o.institutionId
where i.name = 'Pub' and (o.dayOfWeek = 'Friday'
  or o.dayOfWeek = 'Saturday')
order by dayOfWeek;
