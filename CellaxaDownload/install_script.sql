
select '*****************************************************************';
select 'Application Installation Components on'||' '||current_timestamp;
select '*****************************************************************';

\pset pager off
set client_min_messages to warning;
----set client_min_messages to info;

drop owned by cellaxa;
drop user cellaxa;
--------------------
create user cellaxa with password 'cellaxa';

grant all privileges on database "postgres" to cellaxa;	

create user junk with password 'junk';

grant all privileges on database "postgres" to junk;

grant select, update, delete on all tables in schema public to junk;

grant select, update on all sequences in schema public to junk;

SET SESSION AUTHORIZATION cellaxa;

SELECT SESSION_USER, CURRENT_USER;

begin;
----------------------------
CREATE or replace function nothing() 
RETURNS void 
as 
$$
BEGIN
RETURN;
END;
$$ 
language plpgsql;

--------------------------

create sequence _$cxa_frm_seq
INCREMENT  BY 100
     MINVALUE 1 NO MAXVALUE 
    START  WITH 1000 
 CACHE 1000 NO CYCLE; 


create sequence _$cxa_object_seq
INCREMENT  BY 100
     MINVALUE 1 NO MAXVALUE 
    START  WITH 1 NO CYCLE;
-------  CACHE 1000 NO CYCLE; 

create sequence _$cxa_element_seq
INCREMENT  BY 100
     MINVALUE 1 NO MAXVALUE 
    START  WITH 1000  CACHE 1000 NO CYCLE; 

---------------------------

create table _$cxa_servers
(server_id 	int 		primary key 	default 	nextval('_$cxa_object_seq'),
 server_name 	varchar(50) 			default 	'LOCALHOST',
 server_type   	varchar(20) 			default 	'LOCAL', 
 admin_id 	int  				default 	nextval('_$cxa_object_seq'),
 admin_name 	varchar(100) 	unique, 
 admin_password     varchar(250)    	not null,
 c_parameters 	varchar(100),
 crt_datetime   	timestamp 			default clock_timestamp(),
 upd_datetime 	timestamp 			default clock_timestamp()
);

insert into _$cxa_servers
(admin_name,
 admin_password
)
values
(
 'CELLAXA',
 'TEMP_PASSWORD'
);

select * from _$cxa_servers; 

create table _$cxa_users
(server_id 	int 		references 	_$cxa_servers (server_id),
 user_id 		int 		primary key 	default 	nextval('_$cxa_object_seq'),
 user_name 	varchar(250)    	not null,
 user_level     	varchar(5)      	not null 		default ('USER'),
 password 	varchar(250)    	not null                         unique,
 crt_datetime 	timestamp 			default clock_timestamp(),
 upd_datetime 	timestamp 			default clock_timestamp()
);
-------------------------------
create or replace function encipher
(
p_string text 
) returns text 
AS
$$
declare
    p_key                                         text           := '23H%$675)(*HH!@?><';
    c_key_length                            int := 10;
    v_key                                          text := substring(p_key,1,c_key_length*2);
    v_key_length                            int;
    v_result                                      text := '';
    v_each_byte                             int;
    v_each_key_byte                     int;
    v_result_length                         int;
    curr_char                                   text      := null;
    p_string_x                                 text;

string_out text := 'abcdefgklmaq';
start_r int;
start_l int;
length_out int;

new_string       text := '';
token_r            char(1) :=  ''; 
token_l            char(1) := '';

begin

----p_string := rpad(lpad(p_string,32,'987'),64,'abc');


-----string_out := rpad(lpad(p_string,32,'987'),64,'abc');


if mod(length(string_out),2) = 0 then

string_out := rpad(lpad(p_string,32,'987'),64,'abc');

else

string_out := lpad(rpad(p_string,32,'456'),64,'klm');

end if;

------raise NOTICE 'Initial string %', string_out;

length_out := length(string_out);
-----raise NOTICE 'length %', length_out;

for i in 0 .. length_out loop

start_r := length_out - i;
token_r := substring(string_out, start_r,1);

new_string := new_string||token_r;

-----raise NOTICE 'New length %', length(new_string);

if length(new_string) -1 = length_out then
exit;
end if;


start_l := i + 1;
token_l := substring(string_out, start_l,1);

new_string := new_string||token_l;


----if start_r = start_l then
----exit;
-----end if;



end loop;

---- raise NOTICE 'New string %', substring(new_string, 1, length(new_string)- 1);



  p_string :=  substring(new_string, 1, length(new_string)- 1);
 
  p_string := replace (p_string, '0','a');
  p_string := replace (p_string, '1','B');
  p_string := replace (p_string, '2','c');
  p_string := replace (p_string, '3','Z');
  p_string := replace (p_string, '4','a');
  p_string := replace (p_string, '5','Y');
  p_string := replace (p_string, '6','B');
  p_string := replace (p_string, '7','c');
  p_string := replace (p_string, '8','H');
  p_string := replace (p_string, '9','K');
-----------------------------------------------------
  p_string := replace (p_string,'!', 'K');
p_string := replace (p_string,'@', 'Z');
p_string := replace (p_string,'#', 'Y');
p_string := replace (p_string,'$', 'nZ');
p_string := replace (p_string,'%', 'GH');
p_string := replace (p_string,'^', 'QW');
p_string := replace (p_string,'&', 'mn');
p_string := replace (p_string,'*', 'lk');
p_string := replace (p_string,'(', 'sd');
p_string := replace (p_string,')', 'f');
p_string := replace (p_string,'_', 'fd');
p_string := replace (p_string,'-', 'az');
p_string := replace (p_string,'+', 'we');
p_string := replace (p_string,'{', 'vb');
p_string := replace (p_string,'}', 'bv');
p_string := replace (p_string,'|', 'dl');
p_string := replace (p_string,'[', 'po');
p_string := replace (p_string,']', 'qm');
p_string := replace (p_string,'\', 'df');
p_string := replace (p_string,':', 'gh');
p_string := replace (p_string,';', 'e');
p_string := replace (p_string,'"', 'ad');
p_string := replace (p_string,'''', 'zp');
p_string := replace (p_string,'<', 'Z');
p_string := replace (p_string,',', 'sZ');
p_string := replace (p_string,'?', 'fZ');
p_string := replace (p_string,'/', 'h');
p_string := replace (p_string,'>', 'qw');
p_string := replace (p_string,'.', 'wq');
p_string := replace (p_string,'~', 'ty');
p_string := replace (p_string,'`', 'yq');
--------


  p_string := lower(p_string);

-----RAISE NOTICE 'Input %', p_string;
  --
  -- Make sure the key is at least 'c_key_length' chars long with some random junk
  --
    while length(v_key) < c_key_length loop
      v_key := v_key || '@1Z8F$'  || v_key;
    end loop;

   v_key_length := length(v_key);

    v_key := substring(v_key,1,c_key_length);

----raise NOTICE 'Here v_key %', v_key;
  --
  -- For each char in the string
  --
    for i in 1 .. length(p_string) loop
  --
  -- get the ascii vals of the char, and its equivalent in the key
  --
        v_each_byte := ascii(substring(p_string,i,1));
        v_each_key_byte := ascii(substring(v_key,mod(i,c_key_length)+1,1));

-----raise notice 'v_each_byte %',v_each_byte;
-----raise notice 'v_each_key_byte %', v_each_key_byte;

  --
  -- xor the two ascii values and convert back to a char byte
  --
-----     v_result :=  v_result ||
-----         chr(v_each_byte + v_each_key_byte - 2*bitand(v_each_byte,v_each_key_byte));
 

v_result :=  v_result || chr(v_each_byte  - v_each_key_byte );
  

-------raise notice '%', v_result;

 end loop;
--------------------

v_result := replace(v_result,'''','''''');
--------------
return v_result;

/******
EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := '---> System Error detected: '||sqlstate||'\'||sqlerrm;
******/
end;
$$ language plpgsql;
-----------------------
insert into _$cxa_users
(
server_id,
user_id,
user_name,
user_level,
password
)
select server_id, admin_id,  upper(admin_name), 'ADMIN', encipher('cellaxa') from _$cxa_servers
where admin_name = 'CELLAXA';

select * from _$cxa_users; 
-------------------------------------------------
create table _$cxa_sessions
(
user_id    int  references _$cxa_users (user_id), 
session_id numeric primary key,
sequence   text,
active_flag char(1) default 'Y',
crt_date date default clock_timestamp()
);

----------------
create table _$cxa_seq_control
(session_id numeric  references _$cxa_sessions (session_id) on delete cascade,
 curr_seq    numeric,
 retrieved_seq int
);
------------------


create table _$cxa_statements
(
session_id numeric references _$cxa_sessions (session_id),
statement_id int primary key,
crt_date date default clock_timestamp()
);

------- insert into _$cxa_statements (session_id, statement_id) values (100, 9101112);
------------------------------------------------

create or replace function connect
(
 curr_session_id     numeric,
 user_name_in        text,
 password_in           text,
 out session_id_out  numeric,
 out  return_code       int,
 out  message_out    text
)
as
$$
declare
user_id_out int       :=0;
exists_out   int        :=0;
exists1_out int        := 0;
new_session_id numeric :=0;
statement           text;

begin


select count(*) into exists_out 
from _$cxa_sessions
where session_id = curr_session_id;

if exists_out = 0 and curr_session_id > 0 then
return_code := -1;
message_out := '----> ERROR. Invalid currents session identifier';

else



select 
 count(*)  
into  
exists_out
from 
_$cxa_users where 
upper(user_name) = upper(user_name_in) and
password                = encipher(password_in);


          if exists_out = 0 then

         return_code := -1;
         message_out := '----> ERROR. Cannot connect. Invalid User and/or Password.';

         else

select user_id
into user_id_out 
    from _$cxa_users
    where 
upper(user_name) = upper(user_name_in) and
password                = encipher(password_in);



         new_session_id := nextval('_$cxa_object_seq');

update _$cxa_sessions set active_flag = 'N'
where 
            session_id = curr_session_id;


statement := 'create sequence _SE'||new_session_id;

execute statement;

insert into _$cxa_sessions 
(
 user_id,
 session_id,
 sequence
)
values
(
 user_id_out,
 new_session_id,
 '_SE'||new_session_id
);
 

session_id_out := new_session_id;

insert into _$cxa_seq_control
(session_id,
curr_seq,
retrieved_seq
)
values
(new_session_id,
0,
0
); 

------
return_code := 0;
message_out := '----> Connected.';

-----end if;

end if;

end if;


end;

$$

language plpgsql;



------------------------------------------------------
create table _$CXA_data_types (
dt 			int 	primary key, 
cxa_data_type 		text             unique, 
native_data_type 		text);

insert into _$CXA_data_types values (1,		'number',		'numeric');
insert into _$CXA_data_types values (2,		'string',		'text');
insert into _$CXA_data_types values (3,		'date',                     	'date');
insert into _$CXA_data_types values (4,		'date_time',	'timestamp');
insert into _$CXA_data_types values (5,		'date_time_tz', 	'timestamptz');
insert into _$CXA_data_types values (6,		'time', 		'time');
insert into _$CXA_data_types values (7,		'time_tz', 		'timetz');
------------------------------------------------------
insert into _$CXA_data_types values  (8,		'set_id',		'text'); 
insert into _$CXA_data_types values  (9,		'element_id', 	'text');
insert into _$CXA_data_types values  (10, 	'any', 		'text'); /* any data types */ ----------- TEXT ????

----------select * from _$CXA_data_types;

create table _$CXA_structures (
struct_code 	int, 
struct_descr 	text
);

insert into _$CXA_structures values (0, 'Singleton');
insert into _$CXA_structures values (1,'Unordered Homogenous List');
insert into _$CXA_structures values (2 ,'Ordered Homogenous List');
insert into _$CXA_structures values (3,'Unordered Heterogeneous List');
insert into _$CXA_structures values (4,'Ordered Heterogeneous List');
insert into _$CXA_structures values (5,'Linked List');
insert into _$CXA_structures values (6,'Double Linked List');
insert into _$CXA_structures values (7, 'Record');
insert into _$CXA_structures values (8, 'Record Plus');
insert into _$CXA_structures values (9,'Table of records (relational table)');
insert into _$CXA_structures values (10,'Table of records Plus (relational table extended)'); 
insert into _$CXA_structures values (11,'Unbalanced Tree');
insert into _$CXA_structures values (12,'Balanced Tree'); 
insert into _$CXA_structures values (13,'Bulk');
insert into _$CXA_structures values (14, 'Graph');

select * from _$CXA_structures;

create table _$CXA_components
(
descr 		text,
data_type 	int
);

insert into _$CXA_components values ('sequence', 1);
insert into _$CXA_components values ('identifier', 1);
insert into _$CXA_components values ('comprehention', 1);
insert into _$CXA_components values ('payload_num', 1);
insert into _$CXA_components values ('payload_str', 2);
insert into _$CXA_components values ('payload_timestamp', 3);
insert into _$CXA_components values ('payload_timestamp_z', 4);
insert into _$CXA_components values ('payload_date_time', 5);
insert into _$CXA_components values ('payload_date_time_z', 6);
insert into _$CXA_components values ('payload_set_id', 8);
insert into _$CXA_components values ('payload_element', 9);


select * from _$CXA_components;


create table _$cxa_blocks_inventory
(
user_id			int,
user_level                                      text		default 'U',
block_id			int 		primary key,
block_name		text		unique,
s			char(1)		default 'Y',
i			char(1)		default 'Y',
c			char(1)		default 'Y',
p			char(1)		default 'Y',
pl                                                     char(2)                         default 'N',
cxa_data_type		text		references _$cxa_data_types (cxa_data_type),   
native_data_type		text		,
crt_date			timestamp		default clock_timestamp()
);


/****************************************************************/


--------------------------/***************
create or replace function make_sys_blocks
(
out return_code int, 
out message_out text
)    
------returns void
as
$$
declare 
return_code int;
massage_out text;

pl      				record;   ---------- retrieval user_id from _$cxa_data_types

user_id_out                 	      	int;
block_id_out                   	      	int; 
block_name_gen	             	 	text;

payload_data_type                      		text;

cxa_data_type_in                                            text;
native_data_type_in			text;

statement                   			text;       ------------ create block table statement



BEGIN  

-------------------------------------------------------------------------------------
select user_id 
into 
user_id_out
       from _$CXA_users where 
user_name = 'CELLAXA' and 
user_level = 'ADMIN';

/************************************ Full blocks. Not pooled *************/

 FOR pl IN select * from _$cxa_data_types order by dt

    loop

block_id_out		:= nextval('_$cxa_object_seq');
block_name_gen		:= 'S'||block_id_out;

  
       cxa_data_type_in   	:= pl.cxa_data_type;
       native_data_type_in	:= pl.native_data_type;

       payload_data_type	 := pl.native_data_type;

      statement := 
'create table '||block_name_gen||' ( s int, i int, c int, p ' || pl.native_data_type ||')';
  
 raise notice '%', statement; 

       execute  statement;

 insert into _$CXA_blocks_inventory 
      (
user_id		,	
user_level                   ,                  
block_id		,	
block_name	,	
cxa_data_type	,	   
native_data_type	
 )	
values 
(user_id_out,
'A', 
block_id_out,
block_name_gen,
cxa_data_type_in,   
 native_data_type_in
);

end loop;

/************************************  Full blocks. Pooled ************/


 FOR pl IN select * from _$cxa_data_types order by dt

    loop

block_id_out		:= nextval('_$cxa_object_seq');
block_name_gen		:= 'S'||block_id_out;

  
       cxa_data_type_in   	:= pl.cxa_data_type;
       native_data_type_in	:= pl.native_data_type;

-------       payload_data_type	 := pl.native_data_type;

      statement := 
'create table '||block_name_gen||' ( s int, i int, c int,  p int)';
 
 raise notice '%', statement; 

 execute  statement;

 insert into _$CXA_blocks_inventory 
      (
user_id		,	
user_level                   ,                  
block_id		,	
block_name	,	
cxa_data_type	,	   
native_data_type       ,
pl	
 )	
values 
(user_id_out,
'A', 
block_id_out,
block_name_gen,
cxa_data_type_in,   
native_data_type_in,
'Y'
);
  
 end loop;

/***************************************** Null blocks *********************/
 FOR pl IN select * from _$cxa_data_types order by dt

    loop

block_id_out		:= nextval('_$cxa_object_seq');
block_name_gen		:= 'S'||block_id_out;

  
       cxa_data_type_in   	:= pl.cxa_data_type;
       native_data_type_in	:= pl.native_data_type;

-------       payload_data_type	 := pl.native_data_type;

      statement := 
'create table '||block_name_gen||' ( s int, i int, c int)';
 
 raise notice '%', statement; 

 execute  statement;

 insert into _$CXA_blocks_inventory 
      (
user_id		,	
user_level                   ,                  
block_id		,	
block_name	,	
cxa_data_type	,	   
native_data_type       ,
P,
PL
 )	
values 
(user_id_out,
'A', 
block_id_out,
block_name_gen,
cxa_data_type_in,   
native_data_type_in,
'N',
'NA'
);
  
 end loop;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := 'System Error detected: '||sqlstate||'\'||sqlerrm;


END;
$$
language plpgsql;

select * from make_sys_blocks();


create table _$CXA_syntax 
(
s 			int primary key, 
s_name 			text unique, 
s_data_type 		text, 
full_block 		text, 
pooled_block 		text, 
null_block 		text
);
------------------------------------------ Header --------------------------------------
insert into _$cxa_syntax (s, s_name, s_data_type)  values (1, 'setName', 'text');
insert into _$cxa_syntax (s, s_name, s_data_type)  values (2, 'setId', 'numeric');
insert into _$cxa_syntax (s, s_name, s_data_type)  values (3, 'setType', 'numeric');   		------ singletone, etc.
insert into _$cxa_syntax (s, s_name, s_data_type)  values (4, 'setDescr', 'text');			------ long Description
------------------------------------------- Data Holding -----------------------------
insert into _$cxa_syntax (s, s_name, s_data_type)  values (5, 'holderType', 'text');

insert into _$cxa_syntax (s, s_name, s_data_type)  values (6, 'memName','text');  		------ ColumnName (Short Descr)
insert into _$cxa_syntax (s, s_name, s_data_type)  values (7, 'memId', 'numeric');
insert into _$cxa_syntax (s, s_name, s_data_type)  values (8, 'memType', 'numeric');   		------ Value(1), TableAttribute(2)
insert into _$cxa_syntax (s, s_name, s_data_type)  values (9, 'memDataType', 'numeric'); 		------ 1 (numeric), 2 (string), 3 (date)
insert into _$cxa_syntax (s, s_name, s_data_type)  values (10, 'dataBlock', 'numeric');                        ------- Data Block 
--------------------------------------------- Relationships --------------------------
insert into _$cxa_syntax (s, s_name, s_data_type)  values (11, 'memToSet', 'text');      		------ Relationship UP
insert into _$cxa_syntax (s, s_name, s_data_type)  values (12, 'setToMem', 'text');		------ Relationship Down
--------------------------------------------- Ownership ------------------------------ 
insert into _$cxa_syntax (s, s_name, s_data_type)  values (13, 'userID', 'numeric');		------ Ownership


    
----/******
update _$cxa_syntax t1 set  full_block =
t2.block_name from _$cxa_blocks_inventory  t2 where 
t2.native_data_type = t1.s_data_type  and t2.pl = 'N';
------
update _$cxa_syntax t1 set  pooled_block =
t2.block_name from _$cxa_blocks_inventory  t2 where 
t2.native_data_type = t1.s_data_type  and t2.pl = 'Y';
-----
update _$cxa_syntax t1 set  null_block =
t2.block_name from _$cxa_blocks_inventory  t2 where 
t2.native_data_type = t1.s_data_type  and t2.pl = 'NA';
----*******/




/*****
insert into _$CXA_syntax values (1, 'set_id',                        1, 's1002_1_sicp');
insert into _$CXA_syntax values (2, 'set_struct',                  1, 's1002_1_sicp');
insert into _$CXA_syntax values (3, 'set_name',                  2, 's1003_2_sicp');
insert into _$CXA_syntax values (4, 'set_alt_name',            2, 's1003_2_sicp');
insert into _$CXA_syntax values (5, 'set_description',         2, 's1003_2_sicp'); 
insert into _$CXA_syntax values (6,  'set_to_sub_lnk' ,       7, 's1009_7_sicpp');
insert into _$CXA_syntax values (7,  'set_to_super_lnk',    7, 's1009_7_sicpp');
insert into _$CXA_syntax values (8,  'set_ctd_date',           5, 's1006_5_sicp');
insert into _$CXA_syntax values (9,  'set_upd_date',          5, 's1006_5_sicp');
insert into _$CXA_syntax values (10, 'data_holder_block', 2, 's1002_2_sicp');
insert into _$CXA_syntax values (11, 'sub_set_flag',           1, 's1002_1_sicp');
insert into _$CXA_syntax values (12, 'super_set_flag',        1, 's1002_1_sicp');
insert into _$CXA_syntax values (13, 'set_member_data_type', 2, 's1002_1_sicp');
********/

----------------------------**************************/

create table _$cxa_str 
(id numeric primary key, 
 val text unique, 
 val_length int, 
crt_date timestamp default clock_timestamp());
------
create table _$cxa_str_token 
(t_id numeric primary key, 
token text unique, 
crt_date timestamp default clock_timestamp());
------
create table _$cxa_str_map 
(id numeric references    _$cxa_str (id), 
t_id numeric  references _$cxa_str_token (t_id)
);
-------
create table _$cxa_str_navigator
(
id numeric references _$cxa_str (id),
data_type     int default 2,
block_id int references _$cxa_blocks_inventory (block_id),
crt_date timestamp default clock_timestamp() 
);

--------------------------
-------------------------- Pools

create table _$cxa_num 
(id numeric primary key, 
 val numeric unique, 
 crt_date timestamp default clock_timestamp());
------
create table _$cxa_num_navigator
(
id numeric references _$cxa_num (id),
data_type  int default 1,                   
block_id int references _$cxa_blocks_inventory (block_id),
crt_date timestamp default clock_timestamp() 
);
-----------------------------
-----------------------------

create table _$cxa_date
(id numeric primary key, 
 val timestamptz unique, 
 crt_date timestamp default clock_timestamp());
------
create table _$cxa_date_navigator
(
id numeric references _$cxa_date (id),
data_type int default 3,
block_id int references _$cxa_blocks_inventory (block_id),
crt_date timestamp default clock_timestamp() 
);

-------------------------------
------------------------------
create table _$cxa_set_id
(id numeric primary key, 
 val text unique, 
 crt_date timestamp default clock_timestamp());
------
create table _$cxa_set_id_navigator
(
id numeric references _$cxa_set_id (id),
block_id int references _$cxa_blocks_inventory (block_id),
crt_date timestamp default clock_timestamp() 
);

-------------------------------
------------------------------
create table _$cxa_element_id
(id numeric primary key, 
 val text unique, 
 crt_date timestamp default clock_timestamp());
------
create table _$cxa_element_id_navigator
(
id numeric references _$cxa_element_id (id),
block_id int references _$cxa_blocks_inventory (block_id),
crt_date timestamp default clock_timestamp() 
);

create view _$cxa_navigator as
select t1.id, t2.block_id, t2.block_name, t2.native_data_type
from _$cxa_str_navigator t1, _$cxa_blocks_inventory t2
where t1.block_id = t2.block_id
union
select t1.id, t2.block_id, t2.block_name, t2.native_data_type
from _$cxa_num_navigator t1, _$cxa_blocks_inventory t2
where t1.block_id = t2.block_id
union
select t1.id, t2.block_id, t2.block_name, t2.native_data_type
from _$cxa_date_navigator t1, _$cxa_blocks_inventory t2
where t1.block_id = t2.block_id
union
select t1.id, t2.block_id, t2.block_name, t2.native_data_type
from _$cxa_set_id_navigator t1, _$cxa_blocks_inventory t2
where t1.block_id = t2.block_id
union
select t1.id, t2.block_id, t2.block_name, t2.native_data_type
from _$cxa_element_id_navigator t1, _$cxa_blocks_inventory t2
where t1.block_id = t2.block_id;

/**********************************************************/

-----------------------------
create or replace function quit
(
curr_session_id numeric,
out return_code int,
out message_out text
)
as

$$

declare
exists_out  int := 0;

begin

select count(*)  
into exists_out 
from _$cxa_sessions
where session_id = curr_session_id and active_flag = 'Y';

if exists_out = 0 then
return_code := -1;
message_out := '----> Cannot exit. Invalid Current Session identification.';

else

update _$cxa_sessions set active_flag = 'N' where
session_id = curr_session_id;

return_code := 0;
message_out := '----> Exits.';

end if;

end;

$$
language plpgsql; 
------------------------------------------------------------------------ 
create or replace function crt_user 
(
curr_session_id      numeric,
user_name_in 	text,
password_in    	text,
out return_code        int,
out message_out 	text
)
as
$$
declare
       exists_out                    int   := 0; 
----       server_id_out          int   := null;
       curr_user_id_out          int := 0;
       user_name_exists        int     := 0;
       password_exists          int    := 0;
       user_level_out             int    := 0;
       
  
begin

select count(*) into exists_out 
from _$cxa_sessions 
where session_id = curr_session_id and
active_flag = 'Y';

if exists_out = 0 then     
return_code := -1;
message_out := '----> ERROR. Invalid Current Session Identifier';

else   

select user_id  
into curr_user_id_out
from _$cxa_sessions
where session_id = curr_session_id and active_flag = 'Y';

	if curr_user_id_out = 0 then    
	return_code := -1;
	message_out := '----> ERROR. Cannot identify user for a given current session.';

	else 



	select count(*) 
                into user_level_out 
	from _$cxa_users where user_id = curr_user_id_out and user_level = 'ADMIN';

----------	raise NOTICE 'User level %', user_level_out;

			                if  user_level_out   = 0  then   

			                return_code := -1;
               				message_out := '----> ERROR. User cannot be created. Current User is not authorized';

			               else

			               select count(*) 
                			into 
               				user_name_exists
               				from _$cxa_users
              				 where 
               				upper(user_name) = upper(user_name_in);
                                                                -------------------------------
			               select count(*)
               				into 
               				password_exists 
               				from _$cxa_users
              				 where
               				password = encipher(password_in);

			                	if user_name_exists > 0 or password_exists >0 then
                				return_code := -1;
                				message_out := '----> ERROR. User Name and/or Password exist already.';
                
                				else 
                
               					insert into _$cxa_users
              					(server_id, 
              					user_id,
              					user_name,
              					password
               					)
             					values
              					(
              					1,
             					nextval('_$cxa_object_seq'),
             					user_name_in,
             					encipher(password_in)
              					);
  
	  			              return_code := 0;
				              message_out := '----> User '||user_name_in||' is defined.';

					end if;

				end if;  
		end if;  
  end if;
end;
$$
language plpgsql;
----------------------------------------
create or replace function who_am_i
(
session_id_in numeric,
out return_code int,
out message_out text
)
as
$$
declare

user_name_out   text := '';

begin

select  user_name  
into user_name_out
from _$cxa_users t1, 
        _$cxa_sessions t2
where t1.user_id = t2.user_id 
    and t2.session_id = session_id_in
    and t2.active_flag = 'Y';

if user_name_out = '' or user_name_out is null then
return_code := -1;
message_out := '----> No active session is detected. Application is not connected.';

else

return_code := 0;
message_out := 'You are: '||upper(user_name_out); 
 
end if;

end;
$$
language plpgsql;
----------------------------------------
create or replace function genseq
(
session_id_in 		numeric, 
out 	seq_out 		numeric, 
out 	return_code 	int,
out 	message_out 	text
)
as
$$
declare

curr_seq_out           numeric := 0;
retrieved_seq_out   numeric := 0;
session_exists        int := 0;


begin

select count(*) into session_exists
from _$cxa_seq_control where session_id = session_id_in;

    if session_exists = 0 then

    return_code := -1;
    message_out := '----> Invalid Session Identifier.';

    else
 
select 
curr_seq,
retrieved_seq
into 
curr_seq_out,
retrieved_seq_out
from 
_$cxa_seq_control where
session_id = session_id_in;
        


raise INFO 'Status: %', cast(curr_seq_out as text)||' '||cast(retrieved_seq_out as text);



if curr_seq_out = retrieved_seq_out then

retrieved_seq_out := nextval('_$cxa_object_seq');


update _$cxa_seq_control 
set  
retrieved_seq    = retrieved_seq_out, 
curr_seq         = retrieved_seq_out  - 100
where 
session_id       = session_id_in; 

end if;




----- raise INFO 'Status %', retrieved_seq_out - 100;



update _$cxa_seq_control set curr_seq = curr_seq + 1
where 
session_id = session_id_in;


select curr_seq 
into
curr_seq_out
from _$cxa_seq_control
where session_id = session_id_in;






seq_out 		:= curr_seq_out;
return_code 	        := 0;
message_out 	        := '----> Generated.';


end if;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := '----> System Error detected: '||sqlstate||'\'||sqlerrm;


end;
$$
language plpgsql;


---------------------------------------------------


--------------------------------------
      
-------

-----------
create or replace function put_val_one       
(
session_id_in 		numeric,
data_type_in    		int,
val_in               		text,
out return_code_out 	int,
out message_out_top	text,
out pool_id              		int   
)
as
$$
declare
session_id_exists int;

pool_name      text;

statement  text;
id_out        int     := 0;

new_val_num    numeric := 0;
new_val_str       text       := '';
new_val_date    timestamp with time zone;

gen_id               numeric := 0;
return_code_gen   int;
message_out_gen  text; 

begin

select session_id 
into session_id_exists 
from _$cxa_sessions where
session_id = session_id_in;

if session_id_exists is null then
return_code_out  := -1;
message_out_top := '----> ERROR. Invalid Session Identifier.';

-----goto exit;  

-----end if;

else

--------------------------------------------------------NUMBER     
if data_type_in = 1 then

new_val_num :=  cast(val_in as numeric);

------- raise INFO 'Value % ', new_val_num;


 statement := 
'select id  from _$cxa_num where val = '||new_val_num;

------- raise INFO 'Select: %', statement;

execute  statement into id_out;

------- raise INFO 'Retrieved ID: %', id_out;


if id_out is null then

select seq_out, return_code, message_out 
    into 
gen_id,
return_code_gen,
message_out_gen
    from 
genseq(session_id_in);



statement :=
'insert into _$cxa_num (id, val) values ('||gen_id||','||new_val_num||')';

------- raise INFO 'Insert: %', statement;

execute statement;

return_code_out := 0;
message_out_top := '----> Value accepted.'; 
pool_id :=  gen_id;

else

return_code_out := 0;
message_out_top := '----> Value exists.'; 
pool_id :=  id_out;

end if;

end if;
----------------------------------------------------- TEXT ------------------

if data_type_in = 2 then

new_val_str :=  val_in;

------- raise INFO 'Value % ', new_val_num;


 statement := 
'select id  from _$cxa_str where val = '||''''||new_val_str||'''';

------- raise INFO 'Select: %', statement;

execute  statement into id_out;

------- raise INFO 'Retrieved ID: %', id_out;


if id_out is null then

select seq_out, return_code, message_out 
    into 
gen_id,
return_code_gen,
message_out_gen
    from 
genseq(session_id_in);



statement :=
'insert into _$cxa_str (id, val, val_length) values 
('||gen_id||','||''''||new_val_str||''''||',  length('||''''||new_val_str||''''||'))';

------- raise INFO 'Insert: %', statement;

execute statement;

return_code_out := 0;
message_out_top := '----> Value accepted.'; 
pool_id :=  gen_id;

else

return_code_out := 0;
message_out_top := '----> Value exists.'; 
pool_id :=  id_out;

end if;

end if;
----------------------------------------------------- DATE ------------------

if data_type_in = 3 then

statement := 'select timestamp'||''''||val_in||'''';

------- raise INFO 'Convert: %', statement;

execute statement into new_val_date;


------- raise INFO 'Value % ', new_val_date;


 statement := 
'select id  from _$cxa_date where val = '||''''||new_val_date||'''';

------- raise INFO 'Select: %', statement;

execute  statement into id_out;

------- raise INFO 'Retrieved ID: %', id_out;


if id_out is null then

select seq_out, return_code, message_out 
    into 
gen_id,
return_code_gen,
message_out_gen
    from 
genseq(session_id_in);



statement :=
'insert into _$cxa_date (id, val) values 
('||gen_id||','||''''||new_val_date||''''||')';

------- raise INFO 'Insert: %', statement;

execute statement;

return_code_out := 0;
message_out_top := '----> Value accepted.'; 
pool_id :=  gen_id;

else

return_code_out := 0;
message_out_top := '----> Value exists.'; 
pool_id :=  id_out;

end if;

end if;

end if;

EXCEPTION 
WHEN others THEN
return_code_out := -1;
message_out_top:= '----> System Error detected: '||sqlstate||'\'||sqlerrm;

end;
$$
language plpgsql;


----------------------------------
--------drop function put_val_many (numeric, integer[], text[]);
create or replace function put_val_many                          
(
session_id_in 		numeric,
data_type_in 		integer[],
val_in            		text[],
out val_out                              text[],
out seq_out                             int[],
out gen_pool_id                      int[],
out return_code  		int,
out message_out 		text
)
as
$$
declare
how_many int := 0;
pool_name text := '';

return_code_out1   int;
message_out1       text;
pool_id_out            numeric;

how_many_num    int := 0;
how_many_str      int := 0;
how_many_date   int := 0;

session_id_out   numeric; 

seq                       int := 0;

check_date       date;
check_numeric    numeric;  

val_seq          int; 
     

begin

------------------------ Control value data type

select * into how_many from array_length(data_type_in,1);

for k in 1 .. how_many loop

val_seq := k;

if data_type_in[k] = 3 then

check_date := val_in[k];

end if;
-----
if data_type_in[k] = 1 then

check_numeric := val_in[k];

end if;

end loop;

------------------------------------------------------

select session_id 
       into
       session_id_out
       from 
           _$cxa_sessions
       where
            session_id = session_id_in and
            active_flag = 'Y';

                 if session_id_out is null then

                 return_code := -1;
                 message_out := '----> ERROR. Invalid Session Id.';

   
                 else    


if array_length(data_type_in, 1) <> array_length(val_in, 1) then
return_code := -1;
message_out := '----> ERROR. Arrays are invalid: uneven numer of elements.';  

else

       
         


------ raise INFO 'Array Lengh: %', how_many;


for i  in 1 ..  how_many loop

---------------------------------- Data Format Control


-------------------------------------------------------  

-------
select 
return_code_out,
message_out_top,
pool_id
     into
return_code,
message_out,
pool_id_out
     from
put_val_one 
(
session_id_in,
data_type_in[i],   
val_in[i]
);

if data_type_in[i] = 1 then
how_many_num := how_many_num + 1;
end if;

if data_type_in[i] = 2 then
how_many_str := how_many_str + 1;
end if;

if data_type_in[i] = 3 then
how_many_date := how_many_date + 1;
end if;

------ raise INFO 'Output from Numeric Pool: Data Type: %, Value: % , Pool Id: %', data_type_in[i],  val_in[i], pool_id_out;

-------gen_pool_id_out[i][i] := array[[i],[pool_id_out]];

seq_out[i] :=  i;
gen_pool_id[i] := pool_id_out; 
------
val_out[i] := val_in[i];

end loop;

-----end if; --------------------- control

return_code := 0;
message_out := 
'----> Value(s) accepted. Number(s): '||how_many_num||', String(s): '||how_many_str||', Date(s): '||how_many_date;

end if;
end if;
-------end if;  ------ Control

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := '----> ERROR. '||sqlstate||'\'||sqlerrm||'-['||val_seq||'] from left.';

end;

$$
language plpgsql;

----------------------------------------
CREATE OR REPLACE FUNCTION list_usr_sessions(session_id_in int)       
    RETURNS TABLE(
                                  seq            numeric,
                                  user_name text, 
                                  session_id_out numeric, 
                                  active_flag_out character(1)   
                                  )
   AS
$$
DECLARE 
    var_r record;
    message_out  text := '----> OK';       
    return_code int := 0;
    statement    text;
    seq_name_out   text;
    curr_sequence    numeric;

BEGIN
select sequence into 
seq_name_out 
                    from     
                    _$cxa_sessions where session_id = session_id_in and
                                                         active_flag = 'Y'; 
raise INFO 'Sequence Name: %', seq_name_out;

select setval(seq_name_out,1) - 1 into curr_sequence;

raise INFO 'Current Sequence: %', curr_sequence;

FOR var_r IN     (SELECT 
                                          nextval(seq_name_out) - 1 seq,
                                          t2.user_id, 
                                          t2.user_name,    
                                          t1.session_id, 
                                          t1.active_flag
                                           
                FROM _$cxa_users t2 
                             left outer join 
                          _$cxa_sessions t1
                ON t2.user_id = t1.user_id
 )  LOOP
            seq                  := var_r.seq;
            user_name        := var_r.user_name;
            session_id_out := var_r.session_id;
            active_flag_out := var_r.active_flag;
            RETURN NEXT;
     END LOOP;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := '----> System Error detected: '||sqlstate||'\'||sqlerrm;

END;
$$
  LANGUAGE plpgsql;

--------------------------------------
create or replace function change_my_password
(
session_id_in       numeric,
new_password     text,
out return_code   int,
out message_out text
)
as
$$
declare

session_id_out    numeric;
user_id_out         numeric;
new_password_out text;
begin

select t1.session_id,
           t1.user_id
    into
           session_id_out,
           user_id_out
    from
           _$cxa_sessions t1 
where 
t1.session_id = session_id_in and
t1.active_flag = 'Y';

if    session_id_out is null then
      
      return_code := -1;
      message_out := '----> ERROR. Invalid session Id.';
else

new_password_out := encipher(new_password);

update _$cxa_users 
set password = new_password_out 
where
user_id = user_id_out;



return_code := 0;
message_out := '----> Password changed';

end if;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := '----> System Error detected: '||sqlstate||'\'||sqlerrm;


end;

$$
language plpgsql;

-----------------------------------

create or replace function change_someone_password
(
session_id_in       numeric,
user_name_in      text,
new_password     text,
out return_code   int,
out message_out text
)
as
$$
declare

session_id_out    numeric;
user_id_out         numeric;
user_id_out1       numeric;
new_password_out text;
user_level_out         text;
user_level_out1        text;
begin

select t1.session_id,
           t1.user_id,
           t2.user_level
    into
           session_id_out,
           user_id_out,
           user_level_out1
    from
           _$cxa_sessions t1,
           _$cxa_users      t2 
where 
t1.session_id = session_id_in and
t1.user_id = t2.user_id and
t1.active_flag = 'Y';

if    session_id_out is null then
      
      return_code := -1;
      message_out := '----> ERROR. Invalid session Id.';
else

        select 
        user_id,
        user_level
        into
        user_id_out1,
        user_level_out
        from _$cxa_users where
        upper(user_name) = upper(user_name_in);

                        if user_id_out1 is null then
                        return_code := -1;
                        message_out := '----> ERROR. Invalid User Name';

                        else

-----/**************
                              if user_id_out <> user_id_out1 and user_level_out1 = 'ADMIN' then
                              
new_password_out := encipher(new_password);

update _$cxa_users 
set password = new_password_out 
where
user_id = user_id_out1;
return_code := 0;
message_out := '----> Password changed';
                      
                              else
-------****************/           

------raise INFO 'Current user: %, User to change: %, User Level: %', user_id_out, user_id_out1, user_level_out1;                 
 
                              if user_id_out <> user_id_out1 and user_level_out1 = 'USER' then

                              return_code := -1;
                              message_out := '----> ERROR. Change is not authorized.';

                              else

                        
new_password_out := encipher(new_password);

update _$cxa_users 
set password = new_password_out 
where
user_id = user_id_out;



return_code := 0;
message_out := '----> Password changed';


end if;
end if;
end if;
end if;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := 'System Error detected: '||sqlstate||'\'||sqlerrm;


end;

$$
language plpgsql;     

----------------
create or replace function crt_block           
(
session_id_in  numeric,
block_type_in  text,    ------ U or S
layout_type_in text,     ------ F, P, N  	block full, pooled, null
data_type_in   int,       ------ 1,2,3   	block numeric, text, date
out return_code int,
out message_out text
)
as
$$
declare
statement 		text;
block_name 		text;
seq_out1       		numeric;
session_id_out 		numeric;
block_layout  		text;
user_id_out                             int;

cxa_data_type text;
native_data_type text;

p_in    text;
pl_in   text; 

begin

if block_type_in not in ('U','S') then

return_code := -1;
message_out := '----> ERROR. Invalid Block Type (Only U or S allowed)';

else



select session_id,
          user_id
into 
session_id_out,
user_id_out
from 
_$cxa_sessions
where session_id = session_id_in and
active_flag = 'Y';

	if session_id_out is null then

	return_code := -1;
	message_out := '----> ERROR. Invalid Session Id.';

	else

if data_type_in = 1 then

cxa_data_type 	:= 'number';
native_data_type  	:= 'numeric';

end if;

-------
if data_type_in = 2 then

cxa_data_type 	:= 'string';
native_data_type  	:= 'text';

end if;
-------
if data_type_in = 3 then

cxa_data_type 	:= 'date';
native_data_type  	:= 'date';

end if;

	select seq_out into seq_out1 from genseq(session_id_in); 

	block_name :='_'||block_type_in||seq_out1; 

                 if  upper(layout_type_in) =  'F' then   ---------- full block
   
                                 if data_type_in = 1 then ------------------ numeric

                                 block_layout := '( s numeric unique, i numeric, c numeric, p numeric)';

                                 end if;
                                 ---------------
                                 if data_type_in = 2 then ------------------ string

                                 block_layout := '( s numeric unique, i numeric, c numeric, p text)';

                                 end if;
                                 --------------- 
                                 if data_type_in = 3 then ------------------ date

                                 block_layout := '( s numeric unique, i numeric, c numeric, p timestamp with time zone)';

                                 end if;

                    end if;
                    ------------------------------------------------------------

         	if  upper(layout_type_in) = 'P'  then   ---------- pooled block
   
                                 block_layout := '( s numeric unique, i numeric, c numeric, p numeric)';

	end if;


         	if  upper(layout_type_in) = 'N' then   ---------- null block
   
                                 block_layout := '( s numeric unique, i numeric, c numeric)';    

	end if;                
                 -------------------------------------------------------------------   

	statement := 'create table '||block_name||' '||block_layout;

                raise INFO 'Statement, %', statement;

                execute statement;

--------------------------- Populate _$cxa_blocks_inventory here
------/***************

if upper(layout_type_in) = 'F' then
p_in   := 'Y';
pl_in  := 'N';
end if;
-------

if upper(layout_type_in) = 'P' then
p_in   := 'Y';
pl_in  := 'Y';
end if;
--------
if upper(layout_type_in) = 'N' then
p_in   := 'N';
pl_in  := 'NA';
end if;
 insert into _$CXA_blocks_inventory 
(
user_id		,	
user_level                ,                  
block_id		,	
block_name	,	
cxa_data_type	,	   
native_data_type	,
p,
pl
 )	
values 
(user_id_out,    -------- OK
block_type_in,  -------- OK
seq_out1,         --------- OK 
block_name,    --------- OK
cxa_data_type, ---------- OK
native_data_type,
p_in,
pl_in
);



	return_code := 0;
                message_out := 'Block is created and inventoried';

end if;
end if;


EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := 'System Error detected: '||sqlstate||'\'||sqlerrm;

end;
$$
language plpgsql;   
----------------------------------------
create or replace function drp_block      
(
session_id_in numeric,
block_name_in text,
out return_code  int,
out message_out text
)
as
$$
declare 

session_id_out 	numeric;
statement         	text;
block_name_out 	text;
user_id_out             int;

begin

select 
      session_id, 
      user_id
into 
     session_id_out,
     user_id_out
from 
_$cxa_sessions where session_id = session_id_in
and active_flag = 'Y';


  if session_id_out is null then
 
    return_code := -1;
    message_out := '----> ERROR. Invalid Session Id.';

    else

  select 
             block_name 
        into 
             block_name_out
       from 
              _$cxa_blocks_inventory 
      where
      upper(block_name) = upper(block_name_in)
      and user_id = user_id_out;


                      if block_name_out is null then

                      return_code := -1;
                      message_out := '----> ERROR. Invalid Block name or not authorized to drop.';

                      else

                              if upper(substring(block_name_out from 1 for 1)) = 'S' then
               
                              return_code := -1;
                              message_out := '----> ERROR. System block cannot be removed';

                              else 

                      statement := 'drop table '||block_name_in;

                      raise INFO 'Statement: %', statement;

                      execute statement;

 
                      statement := 
                     'delete from _$cxa_blocks_inventory where upper(block_name) = upper('
                     ||''''||block_name_in||''''||')';

                       raise INFO 'Statement: %', statement;

                      execute statement; 

                      return_code := 0;
                      message_out := '----> Block removed.';

                      end if;
                      end if; 
        
 end if;

EXCEPTION 
WHEN others THEN
return_code := -1;
message_out := 'System Error detected: '||sqlstate||'\'||sqlerrm;


end;
$$
language plpgsql;    




end;

\d



/******
create or replace function test_run()
returns text
as
$$
declare
test_id int :=0;
begin
          
          declare

          client_id_out1   int;
          return_code1    int;
          session_id_out1   numeric;
          message_out1      text;

          begin
raise INFO '**************************************';
raise INFO 'Testing GENERAL_CONNECT()';
raise INFO '**************************************';
 ------------------------------------------
select 
          client_id_out,
          return_code,
          session_id_out,
          message_out 
into 
         client_id_out1,
          return_code1,
          session_id_out1,
          message_out1
 from 
         general_connect(0);

      raise INFO 'Run 1.Expected OK.->%',
     ' Ret.Code:'||return_code1||
','||'Msg.:'||message_out1||
','||'Client Id:'||client_id_out1||
','||'Session Id:'||' '||session_id_out1;          

------------------------------------------

select 
          client_id_out,
          return_code,
          session_id_out,
          message_out 
into 
         client_id_out1,
          return_code1,
          session_id_out1,
          message_out1
 from 
         general_connect(client_id_out1);

      raise INFO 'Run 2.Expected OK.->%',
     ' Ret.Code:'||return_code1||
','||'Msg.:'||message_out1||
','||'Client Id:'||client_id_out1||
','||'Session Id:'||' '||session_id_out1;         
--------------------------------------------------------
select 
          client_id_out,
          return_code,
          session_id_out,
          message_out 
into 
          client_id_out1,
          return_code1,
          session_id_out1,
          message_out1
 from 
         general_connect(1000);

         client_id_out1:= coalesce(client_id_out1, 0);
          return_code1:= coalesce(return_code1, 0); 
          session_id_out1 := coalesce(session_id_out1,0);





      raise INFO 'Run 3.Expected ERR.->%',
     ' Ret.Code:'||return_code1||
','||'Msg.:'||message_out1||
','||'Client Id:'||client_id_out1||
','||'Session Id:'||' '||session_id_out1;          


         end;


raise INFO '**************************************';
raise INFO 'Testing EXIT()';
raise INFO '**************************************';


return 'End of test.';
end;
$$
language plpgsql;
******/
------select * from test_run();

RESET SESSION AUTHORIZATION;

SELECT SESSION_USER, CURRENT_USER;


\q

