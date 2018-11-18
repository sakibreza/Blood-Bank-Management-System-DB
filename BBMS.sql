-- drop tables

drop table Donate;
drop table BloodBank;
drop table Donar;
drop table Patient;


-- create tables

create table Patient(
    patient_id integer,
    patient_name varchar(20) not null,
    blood_group varchar(4),
    disease varchar(20),
    patient_address varchar(20),
    patient_contact_no varchar(20),
    primary  key (patient_id)
);

create table Donar(
    donar_id integer,
    donar_name varchar(20) not null,
    blood_group varchar(4),
    donar_contact_no varchar(20),
    donar_address varchar(20),
    disease varchar(20),
    primary key (donar_id)
);

create table BloodBank(
    blood_bank_id integer,
    blood_bank_name varchar(20),
    blood_bank_address varchar(20),
    blood_bank_contact_no varchar(20),
    primary key (blood_bank_id)
);

create table Donate(
    donate_id integer,
    donar_id integer,
    date_of_donation date,
    blood_bank_id integer,
    flag integer default 1,
    primary key(donate_id),
    foreign key (donar_id) references Donar(donar_id),
    foreign key (blood_bank_id) references BloodBank(blood_bank_id)
);

-- data insertion of patient 

insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1001,'PA','A+','N/A','Dhaka','01234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1002,'PB','B+','N/A','Khulna','04234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1003,'PC','A+','N/A','Khulna','01634');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1004,'PD','B+','N/A','Dhaka','01294');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1005,'PE','A+','N/A','Dhaka','01434');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1006,'PF','A+','N/A','Dhaka','01234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1007,'PG','B+','N/A','Khulna','04234');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1008,'PH','A+','N/A','Khulna','01634');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1009,'PI','B+','N/A','Dhaka','01294');
insert into Patient (patient_id,patient_name,blood_group,disease,patient_address,patient_contact_no)
            values(1010,'PJ','A+','N/A','Dhaka','01434');
             

-- data insertion of donar

insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(101,'DA','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(102,'DB','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(103,'DC','B+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(104,'DD','A+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(105,'DE','B+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(106,'DF','A+','0134','Chittagong');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(107,'DG','A+','0134','Dhaka');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(108,'DH','B+','0134','Khulna');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(109,'DI','A+','0134','Chittagong');
insert into Donar (donar_id,donar_name,blood_group,donar_contact_no,donar_address)
            values(110,'DJ','B+','0134','Dhaka');
 
            
-- data insertion of blood bank

insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(1,'BBA','Dhaka','911');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(2,'BBB','Khulna','912');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(3,'BBC','Dhaka','913');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(4,'BBD','Khulna','914');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(5,'BBE','Dhaka','915');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(6,'BBF','Khulna','916');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(7,'BBG','Dhaka','917');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(8,'BBH','Khulna','918');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(9,'BBI','Dhaka','919');
insert into BloodBank (blood_bank_id,blood_bank_name,blood_bank_address,blood_bank_contact_no)
            values(10,'BBJ','Khulna','920');
        
-- data insertion of donation 

insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10001,101,TO_DATE('28/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10002,104,TO_DATE('27/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10003,102,TO_DATE('26/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10004,106,TO_DATE('25/04/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10005,105,TO_DATE('24/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10006,106,TO_DATE('28/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10007,107,TO_DATE('27/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10008,108,TO_DATE('26/02/2018', 'DD/MM/YYYY'),1);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10009,109,TO_DATE('25/02/2018', 'DD/MM/YYYY'),2);
insert into Donate (donate_id,donar_id,date_of_donation,blood_bank_id)
            values(10010,110,TO_DATE('24/02/2018', 'DD/MM/YYYY'),1);
commit;
                                                                                                                                                      
                                                                                                                                                      