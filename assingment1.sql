create database ticketbookingsystem;

use ticketbookingsystem;

create table venue (
    venue_id int primary key,
    venue_name varchar(255) not null,
    address varchar(255) not null
);

create table event (
    event_id int primary key,
    event_name varchar(255) not null,
    event_date date,
    event_time time,
    venue_id int,
    total_seats int,
    available_seats int,
    ticket_price decimal(10, 2),
    event_type enum('movie', 'sports', 'concert'),
    booking_id int,
    foreign key (venue_id) references venu(venue_id),
);

create table customer (
    customer_id int primary key,
    customer_name varchar(255) not null,
    email varchar(255),
    phone_number varchar(15),
    booking_id int,
    foreign key (booking_id) references booking(booking_id) 
);

create table booking (
    booking_id int primary key,
    customer_id int,
    event_id int,
    num_tickets int,
    total_cost decimal(10, 2),
    booking_date datetime default current_timestamp,
    foreign key (customer_id) references customer(customer_id),
);

insert into venu (venue_id, venue_name, address) values
(1, 'venue 1', 'address 1'),
(2, 'venue 2', 'address 2'),
(3, 'venue 3', 'address 3'),
(4, 'venue 4', 'address 4'),
(5, 'venue 5', 'address 5');
(6, 'venue 6', 'address 5');
(7, 'venue 7', 'address 5');
(8, 'venue 8', 'address 5');
(9, 'venue 9', 'address 5');
(10, 'venue 10', 'address 5');

insert into event (event_id, event_name, event_date, event_time, venue_id, total_seats, available_seats, ticket_price, event_type, booking_id)
values
(1, 'event 1', '2024-05-01', '18:00:00', 1, 200, 100, 1500.00, 'movie', 101),
(2, 'event 2', '2024-05-02', '19:00:00', 2, 150, 50, 2000.00, 'sports', 102),
(3, 'event 3', '2024-05-03', '20:00:00', 3, 300, 200, 1800.00, 'concert', 103),
(4, 'event 4', '2024-05-04', '21:00:00', 4, 250, 100, 2200.00, 'movie', 104),
(5, 'event 5', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert',  105);
(6, 'event 6', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert', 106);
(7, 'event 7', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert', 107);
(8, 'event 8', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert', 108);
(9, 'event 9', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert', 109);
(10, 'event 10', '2024-05-05', '22:00:00', 5, 400, 300, 2500.00, 'concert', 110);

insert into customer (customer_id, customer_name, email, phone_number, booking_id)
values
(1, 'john doe', 'john@example.com', '1234560001', 101),
(2, 'jane smith', 'jane@example.com', '2345670002',102),
(3, 'alice johnson', 'alice@example.com', '3456780003',103),
(4, 'bob brown', 'bob@example.com', '4567890004', 104),
(5, 'emily davis', 'emily@example.com', '5678900005', 105);
(6, 'davis', 'davis@example.com', '5678900005', 106);
(7, 'mike', 'mike@example.com', '5678900005', 107);
(8, 'adam', 'adam@example.com', '5678900005', 108);
(9, 'will jacks', 'will@example.com', '5678900005', 109);
(10, 'de villiars', 'devilliars@example.com', '5678900005', 110);


insert into booking (booking_id, customer_id, event_id, num_tickets, total_cost, booking_date)
values
(101, 1, 1, 2, 3000.00, "2024-10-23"),
(102, 2, 2, 3, 6000.00, "2024-6-20"),
(103, 3, 3, 4, 7200.00, "2024-1-10"),
(104, 4, 4, 2, 4400.00, "2024-9-20"),
(105, 5, 5, 5, 12500.00, "2024-11-3");
(106, 5, 5, 5, 12500.00, "2024-1-5");
(107, 5, 5, 5, 12500.00, "2024-10-7");
(108, 5, 5, 5, 12500.00, "2024-8-9");
(109, 5, 5, 5, 12500.00, "2024-9-14");
(110, 5, 5, 5, 12500.00, "2024-12-23");

alter table event add contraint event foreign key(booking_id) references booking(booking_id);
alter table customer add contraint customer foreign key(booking_id) references booking(booking_id);

select * from event;

select * from event where available_seats > 0;

select * from event where event_name like '%cup%';

select * from event where ticket_price between 1000 and 2500;

select * from event where event_date between '2024-05-01' and '2024-05-05';

select * from event where available_seats > 0 and event_name like '%concert%';

select * from booking where num_tickets > 4;

select * from customer where phone_number like '%000';

select * from event where total_seats > 15000 order by event_name;

select * from event where event_name not like 'x%' and event_name not like 'y%' and event_name not like 'z%';

select event_id, event_name, avg(ticket_price) as avg_ticket_price
from event
group by event_id, event_name;

select sum(total_cost) as total_revenue
from booking;

select event_id, event_name, sum(num_tickets) as total_tickets_sold
from booking
group by event_id, event_name
order by total_tickets_sold desc
limit 1;

select event_id, event_name, sum(num_tickets) as total_tickets_sold
from booking`
group by event_id, event_name;

select event_id, event_name
from event
left join booking on event.event_id = booking.event_id
where booking.booking_id is null;

select customer_id, customer_name, count(booking_id) as total_bookings
from booking
group by customer_id, customer_name
order by total_bookings desc
limit 1;

select month(event_date) as month, sum(num_tickets) as total_tickets_sold
from booking
join event on booking.event_id = event.event_id
group by month(event_date);

select venue_id, venue_name, avg(ticket_price) as avg_ticket_price
from event
join venu on event.venue_id = venu.venue_id
group by venue_id, venue_name;

select event_type, sum(num_tickets) as total_tickets_sold
from event
join booking on event.event_id = booking.event_id
group by event_type;

select year(event_date) as year, sum(total_cost) as total_revenue
from booking
join event on booking.event_id = event.event_id
group by year(event_date);

select customer_id, customer_name, count(distinct event_id) as total_events_booked
from booking
join customer on booking.customer_id = customer.customer_id
group by customer_id, customer_name
having total_events_booked > 1;

select customer_id, customer_name, sum(total_cost) as total_revenue
from booking
join customer on booking.customer_id = customer.customer_id
group by customer_id, customer_name;

select venu.venue_id, venu.venue_name, event.event_type, avg(event.ticket_price) as avg_ticket_price
from event
join venu on event.venue_id = venu.venue_id
group by venu.venue_id, venu.venue_name, event.event_type;

select customer_id, customer_name, count(booking_id) as total_tickets_purchased
from booking
join customer on booking.customer_id = customer.customer_id
where booking_date >= date_sub(curdate(), interval 30 day)
group by customer_id, customer_name;

select venue_id, venue_name,
       (select avg(ticket_price) 
        from event 
        where event.venue_id = venu.venue_id) as avg_ticket_price
from venu;

select event_id, event_name
from event
where (select sum(num_tickets) from booking where booking.event_id = event.event_id) > 0.5 * total_seats;

select event.event_id, event.event_name, (sum(booking.num_tickets), 0) as total_tickets_sold
from event
left join booking on event.event_id = booking.event_id
group by event.event_id, event.event_name;

select customer_id, customer_name
from customer
where not exists (
    select * from booking where booking.customer_id = customer.customer_id
);

select event_id, event_name
from event
where event_id not in (select distinct event_id from booking);

select event_type, sum(total_tickets_sold) as total_tickets_sold
from (
    select event.event_type, (sum(booking.num_tickets), 0) as total_tickets_sold
    from event
    left join booking on event.event_id = booking.event_id
    group by event.event_id, event.event_type
) as subquery
group by event_type;

select event_id, event_name, ticket_price
from event
where ticket_price > (select avg(ticket_price) from event);

select customer.customer_id, customer.customer_name,
       (select (sum(booking.total_cost), 0) 
        from booking 
        where booking.customer_id = customer.customer_id) as total_revenue
from customer;

select customer_id, customer_name
from customer
where exists (
    select * from booking
    join event on booking.event_id = event.event_id
    where event.venue_id = (select venue_id from venu where venue_name = 'given venue name')
      and booking.customer_id = customer.customer_id
);

select event_type, (sum(total_tickets_sold), 0) as total_tickets_sold
from (
    select event.event_type, (sum(booking.num_tickets), 0) as total_tickets_sold
    from event
    left join booking on event.event_id = booking.event_id
    group by event.event_id, event.event_type
) as subquery
group by event_type;

select customer_id, customer_name, month(booking_date) as booking_month
from booking
join customer on booking.customer_id = customer.customer_id
group by customer_id, customer_name, booking_month;

select venue_id, venue_name,
       (select avg(ticket_price) 
        from event 
        where event.venue_id = venu.venue_id) as avg_ticket_price
from venu;

