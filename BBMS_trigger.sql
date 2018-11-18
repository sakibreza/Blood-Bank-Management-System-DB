create or replace trigger desease_trg
before insert on Donar
for each row
when(NEW.donar_id>0)
begin
    if :NEW.disease = 'HepB' then
        dbms_output.put_line('donar with fatal disease!');
        delete from donar where donar_id = :NEW.donar_id;
    end if;
end;



create or replace trigger loc_change
before update on Donar
for each row
when(NEW.donar_address!=OLD.donar_address)
declare 
  
begin
    dbms_output.put_line('Old location : '|| :OLD.donar_address);
    dbms_output.put_line('New location : '|| :NEW.donar_address);
end;

create or replace trigger blood_received
before update on Donate
for each row
when(NEW.flag!=OLD.flag)
declare 
  
begin
    dbms_output.put_line('Blood bag given to the patient');
end;