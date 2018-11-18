-- queries 

-- random queries 
-- select donar_name,blood_group from donar where blood_group = (select blood_group from Patient where -- patient_id=1001);
-- select blood_group from Donar where donar_id in (select donar_id from Donate where donar_id=101);
-- select blood_group from Patient where patient_id=1001;
-- select donar_name,blood_group from Donar;

-- donar available for a particular patient
select donar_id,donar_name,blood_group,donar_contact_no from Donar where donar_id in (select donar_id from Donate where donar_id in (select donar_id from donar where blood_group in (select blood_group from Patient where patient_id=1001)) );

-- blood bank where desired blood available for a particular patient

select blood_bank_id,blood_bank_name,blood_bank_contact_no from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group in (select blood_group from Patient where patient_id=1001)));

-- blood bank where desired blood available for a particular patient and the blood bank is located in patient's location 
select blood_bank_id,blood_bank_name,blood_bank_contact_no,blood_bank_address from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group = (select blood_group from Patient where patient_id=1001)) ) and blood_bank_address in (select patient_address from Patient where patient_id=1001);

-- blood bank where desired blood available
select blood_bank_id,blood_bank_name,blood_bank_contact_no from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group = 'A+'));

-- quantity of desired blood in a particular blood bank
select count(donate_id) as quantity_of_desired_blood from Donate where blood_bank_id = 1 and donar_id in (select donar_id from Donar where blood_group = 'A+');

select d.donar_name,b.blood_bank_name from Donar d,BloodBank b,Donate dd where dd.donate_id=10001 and d.donar_id in (select donar_id from Donate where donate_id = 10001) and b.blood_bank_id in (select blood_bank_id from Donate where donate_id = 10001);

select donar_name,blood_group,patient_name from Donar natural join Patient;