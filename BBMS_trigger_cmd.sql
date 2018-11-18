set serveroutput on

update Donar set donar_address = 'Bogra' where donar_id = 101 ;

insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address,disease)
            values(111,'DX','B+','0134','Dhaka','HepB');

update Donate set flag = 0 where donate_id = 10001;