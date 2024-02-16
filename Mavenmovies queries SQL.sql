-- SQL WEEK 3 PROJECT -- S5426
use mavenmovies;
-- Question 1
select (concat(first_name," ",last_name)) as Actor_Name , 
length(concat(first_name," ",last_name))-length(" ") as lengthofName  
from actor
limit 10; 

select trim("first_name" " " "last_name") from actor limit 1;
-- -----------------------------------------------------------------------------
-- Question 2 -- Awardees who recieved only Oscars 
select concat(first_name," ",last_name) as Oscar_Awardees_Names,
length(concat(first_name," ",last_name))-length(" ") as lengthofName , awards
from actor_award
where awards like "%oscar%" ;

-- Question 2 -- awardees who recieved oscars with other awards

select concat(first_name," ",last_name) as Oscar_Awardees_Names,
length(concat(first_name," ",last_name))-length(" ") as lengthofName , awards
from actor_award
where awards="oscar" or awards not in ("Tony") and awards not in ("Emmy") ;

-- -----------------------------------------------------------------------------------

-- Question 3
select concat(a.first_name," ",a.last_name) as Actor_names ,f.title as Film_Name
from actor a
inner join film_actor fa
on a.actor_id=fa.actor_id
inner join film f
on f.film_id= fa.film_id
where title = "Frost Head";
-- ------------------------------------------------------------------------------------------------
-- Question 4
select f.title as Films,f.film_id from film f 
inner join film_actor fa on f.film_id=fa.film_id
inner join actor a on a.actor_id=fa.actor_id
-- where first_name="Will" and Last_name="Wilson";
where concat(first_name," ",last_name) ="Will Wilson";
-- --------------------------------------------------------------------------------------------------
-- Question 5
select f.title as Films_rented_returned ,r.rental_id,f.film_id,rental_date,return_date from film f
inner join inventory i 
on f.film_id=i.film_id
inner join rental r
on r.inventory_id= i.inventory_id
where monthname(rental_date)="May" and  monthname(return_date)="May";
-- ---------------------------------------------------------------------------------------------------
-- Question 6
select f.title as Comedy_Films ,fc.film_id from film f
inner join film_category fc
on f.film_id=fc.film_id
inner join category c
on c.category_id =  fc.category_id
where c.name ="Comedy";

--------------------------------------------------------------------------------------------

select t.tag_name as TagName, count(pt.photo_id) as tot_photos,
dense_rank() over(order by count(distinct(pt.photo_id)) desc)-1 as rank_Photos FROM tags t
inner join photo_tags pt
on pt.tag_id = t.id
group by t.tag_name with rollup
order by tot_photos desc;  

-- sum(count_photo) over(partition by Creation_Date,User_ID order by Creation_Date desc rows between 1 preceding and current row) as la 
-- (lead(count_photo,1) over(partition by User_ID order by Creationdate desc) +
-- lag(count_photo,1) over(partition by User_ID order by Creationdate desc) ) as la 

select u.id as User_ID,u.username,p.id as Photo_ID,u.created_at,
count(p.id) over(partition by u.id order by u.created_at desc) as count_photo,
lead(count_photo,1) over(partition by u.id order by u.created_at) as le,
lag(count_photo,1) over(partition by u.id order by u.created_at ) as la from users u
inner join photos p on p.user_id = u.id
group by u.created_at,p.id 
order by u.created_at;





