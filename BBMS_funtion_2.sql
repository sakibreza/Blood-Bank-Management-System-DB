SET SERVEROUTPUT ON

DECLARE



PROCEDURE donars_for_particular_patient (pid IN Patient.patient_id%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of donars for patient id no. '||pid);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    FOR cursor1 IN (select donar_id,donar_name,blood_group,donar_contact_no from Donar where donar_id in (select donar_id from Donate where donar_id in (select donar_id from donar where blood_group in (select blood_group from Patient where patient_id=pid)) )) 
          LOOP
            DBMS_OUTPUT.PUT_LINE('donar name: ' || cursor1.donar_name ||
                               ', blood group: ' || cursor1.blood_group||
                               ', contact no: ' || cursor1.donar_contact_no);
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;


PROCEDURE banks_available_for_patient (pid IN Patient.patient_id%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of blood banks for patient id no. '||pid);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------');
    FOR cursor1 IN (select blood_bank_id,blood_bank_name,blood_bank_contact_no from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group in (select blood_group from Patient where patient_id=1001))))
        LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || cursor1.blood_bank_id ||
                               ', blood bank name: ' || cursor1.blood_bank_name||
                               ', contact no: ' || cursor1.blood_bank_contact_no);
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');    
END;


PROCEDURE bank_in_patients_place (pid IN Patient.patient_id%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of blood bank for patient id no.'||pid|| ' in his/her place');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------');
    
    FOR cursor1 IN (select blood_bank_id,blood_bank_name,blood_bank_contact_no,blood_bank_address from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group = (select blood_group from Patient where patient_id=1001)) ) and blood_bank_address in (select patient_address from Patient where patient_id=1001))
          LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || cursor1.blood_bank_id ||
                               ', blood bank name: ' || cursor1.blood_bank_name||
                               ', contact no: ' || cursor1.blood_bank_contact_no);
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

PROCEDURE bank_desired_blood_quantity (blood IN Patient.blood_group%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of blood bank for blood group '||blood|| ' with its quantity');
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
    
    FOR cursor1 IN (select blood_bank_name,count(*) as quantity from (select T.BLOOD_BANK_NAME,T.BLOOD_BANK_CONTACT_NO from (select * from BloodBank natural join Donate) t natural join (select * from Donar where blood_group=blood)) group by blood_bank_name)          
        LOOP
            DBMS_OUTPUT.PUT_LINE('blood bank name: ' || cursor1.blood_bank_name ||
                               ', quantity: ' || cursor1.quantity
                               );
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

PROCEDURE blood_group_quantity_in_bank (bank_no IN BloodBank.blood_bank_id%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of blood group with quantity in blood bank no. '||bank_no);
    DBMS_OUTPUT.PUT_LINE('------------------------------------------------------------------');
    
    FOR cursor1 IN (select blood_group,count(*) as quantity from (select * from Donate natural join Donar) where blood_bank_id = bank_no group by blood_group)
        LOOP
            DBMS_OUTPUT.PUT_LINE('blood group: ' || cursor1.blood_group ||
                               ', quantity: ' || cursor1.quantity
                               );
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

PROCEDURE bank_with_desired_blood (blood IN donar.blood_group%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of blood banks having '||blood||' blood');
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------');
    
    FOR cursor1 IN (select blood_bank_id,blood_bank_name,blood_bank_contact_no from BloodBank where blood_bank_id in (select blood_bank_id from Donate where donar_id in (select donar_id from donar where blood_group = blood)))
        LOOP
            DBMS_OUTPUT.PUT_LINE('id: ' || cursor1.blood_bank_id ||
                               ', blood bank name: ' || cursor1.blood_bank_name||
                               ', contact no: ' || cursor1.blood_bank_contact_no);
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;


PROCEDURE quantity_of_group_in_bank (bank IN donate.blood_bank_id%type, blood IN donar.blood_group%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('quantity of blood in bank no. '||bank||' of group '||blood);
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------');
    
    FOR cursor1 IN (select count(donate_id) as quantity from Donate where blood_bank_id = bank and donar_id in (select donar_id from Donar where blood_group = blood))
           LOOP
            DBMS_OUTPUT.PUT_LINE('quantity of blood bag : ' || cursor1.quantity);
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

PROCEDURE donar_of_group_before_date (date_ IN donate.date_of_donation%type, blood IN donar.blood_group%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of donar of '||blood||' blood donated before '||date_);
    DBMS_OUTPUT.PUT_LINE('---------------------------------------------------------------');
    
    FOR cursor1 IN (select donar_name,blood_group,date_of_donation,donar_contact_no from (select * from donate natural join donar) where date_of_donation < date_ and blood_group=blood)
           LOOP
            DBMS_OUTPUT.PUT_LINE('donar name: ' || cursor1.donar_name ||
                                 ', blood group: '|| cursor1.blood_group ||
                                 ', date of donation: '|| cursor1.date_of_donation ||
                                 ', contact no: '|| cursor1.donar_contact_no
                                );
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

PROCEDURE available_blood_of_group_date (date_ IN donate.date_of_donation%type,blood IN donar.blood_group%type) IS 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('List of available '||blood||' blood before '||date_);
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    
    FOR cursor1 IN (select donate_id,donar_name,blood_group,blood_bank_name,blood_bank_contact_no from (select * from donate natural join BloodBank) t natural join donar where t.FLAG=1 and donar.blood_group=blood and t.date_of_donation < date_)           LOOP
            DBMS_OUTPUT.PUT_LINE('donate id: ' || cursor1.donate_id ||
                                 ', donar name: '|| cursor1.donar_name ||
                                 ', blood: '|| blood ||
                                 ', blood bank: '|| cursor1.blood_bank_name||
                                 ', contact no: '||cursor1.blood_bank_contact_no
                                );
          END LOOP;
    DBMS_OUTPUT.PUT_LINE('_________________________________________');
END;

BEGIN
    donars_for_particular_patient(1001);
    banks_available_for_patient(1001);
    bank_in_patients_place(1001);
    bank_desired_blood_quantity('A+');
    blood_group_quantity_in_bank(1);
    bank_with_desired_blood('A+');
    quantity_of_group_in_bank(1,'A+');
    donar_of_group_before_date(TO_DATE('26/03/2018', 'DD/MM/YYYY'),'A+');
    available_blood_of_group_date(TO_DATE('26/03/2018', 'DD/MM/YYYY'),'A+');
END;