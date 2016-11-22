/*1. See who is currently checked in at the pub and is a meal sponsor
* (People who have checked in will be deleted from
* the database after one hour. So, anyone in the table
* will be checked in)
*/
select firstName, lastName from User u
where u.id in (select userId from CheckIn c
  join Location l on l.id = c.locationId
  where name = "Pub" and sponsor = 1)
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
join DishXMenu dxm on dxm.dishId = d.id
join Menu m on dxm.menuId = m.id
where m.date = '2016-10-21' and d.FoodTypeId = 2
order by d.name;

/*4. display all dishes that ever received a score 2 under*/
select d.name from Dish d
join Rating r on r.dishId = d.id
where r.score <= 2
order by d.name;

/*5. Display when dining room is open for lunch on saturday*/

select timeOpens, timeCloses from Institution i join OperationHours oh on i.id = institutionId
where i.name = "Dining Room" and oh.name = "Lunch" and dayOfWeek = "Saturday";

/*6. Display how late the grill is open at the pub on Friday*/

select timeOpens, timeCloses from Institution i join OperationHours oh on i.id = institutionId
where i.name = "Pub Grill" and oh.name = "Dinner" and dayOfWeek = "Friday";

/*7. Display the menu for a Breakfast on certain date*/

select d.name from Dish d join DishXMenu dxm on d.id = dishId
join Menu m on m.id = menuId
join OperationHours oh on oh.id = operationHoursId
where oh.name = "Breakfast" and date = "2017-02-02";

/*8. Display all comments about all dishes for a certain meal*/

select d.name, comment from Rating r join Dish d on r.dishId = d.id
join DishXMenu dxm on d.id = dxm.dishId
join Menu m on menuId = m.id
where m.id = 1 order by d.id, r.date;

/* 9. Show all comments made on dishes about a lunch meal */
select d.name, comment from Rating r
join Dish d on d.id = r.dishId
join DishXMenu dxm on dxm.dishId = d.id
join Menu m on m.id = dxm.menuId
join OperationHours oh on oh.id = m.operationHoursId
where oh.name = "Lunch"
order by d.name, r.date;

/* 10. Display all comments by a certain user */
select u.id, u.firstName, u.lastName, r.comment from User u
join Rating r on r.userId = u.id
where u.id = 2
order by r.date;

/*11. Display average rating for vegan dishes*/
select avg(score) as 'Average Rating' from Rating r
join Dish d on r.dishId = d.id
join FoodType f on f.id = d.FoodTypeId
where f.type = 'Vegetarian';

/*12. Display pub hours for Friday and Saturday
* Overall pub hours doesn't include pub grill
*/
select dayOfWeek, timeOpens, timeCloses from OperationHours o
join Institution i on i.id = o.institutionId
where i.name = 'Pub' and (o.dayOfWeek = 'Friday'
  or o.dayOfWeek = 'Saturday')
order by dayOfWeek;
