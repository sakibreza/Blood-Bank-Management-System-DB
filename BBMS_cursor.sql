SET SERVEROUTPUT ON
DECLARE
    total_rows integer;
begin
--cursor
   update Donar
   set donar_address = 'Chattogram'
   where donar_address = 'Chittagong';
   if sql%notfound then 
      dbms_output.put_line('no donars address changed'); 
   elsif sql%found then 
      total_rows := sql%rowcount;
      dbms_output.put_line( total_rows || ' donars address changed '); 
   end if; 
end;