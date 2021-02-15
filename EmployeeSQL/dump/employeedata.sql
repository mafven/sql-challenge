--
-- PostgreSQL database dump
--

-- Dumped from database version 12.5
-- Dumped by pg_dump version 12.5

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: departments; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.departments (
    dept_no character varying(20) NOT NULL,
    dept_name character varying(250)
);


ALTER TABLE public.departments OWNER TO postgres;

--
-- Name: dept_emp_numbers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.dept_emp_numbers (
    emp_no integer NOT NULL,
    dept_no character varying NOT NULL
);


ALTER TABLE public.dept_emp_numbers OWNER TO postgres;

--
-- Name: employees; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.employees (
    emp_no integer NOT NULL,
    emp_title_id character varying,
    birth_date date,
    first_name character varying,
    last_name character varying,
    sex character varying,
    hire_date date
);


ALTER TABLE public.employees OWNER TO postgres;

--
-- Name: departament_view; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.departament_view AS
 SELECT e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp_numbers de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((d.dept_no)::text = (de.dept_no)::text)));


ALTER TABLE public.departament_view OWNER TO postgres;

--
-- Name: managers; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.managers (
    dept_no character varying,
    emp_no integer
);


ALTER TABLE public.managers OWNER TO postgres;

--
-- Name: mara; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.mara (
    adm character varying
);


ALTER TABLE public.mara OWNER TO postgres;

--
-- Name: salaries; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.salaries (
    emp_no integer NOT NULL,
    salary integer
);


ALTER TABLE public.salaries OWNER TO postgres;

--
-- Name: titles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.titles (
    title_id character varying(20) NOT NULL,
    title character varying(250)
);


ALTER TABLE public.titles OWNER TO postgres;

--
-- Name: vw_dept_managers; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_dept_managers AS
 SELECT m.dept_no,
    d.dept_name,
    m.emp_no,
    e.last_name,
    e.first_name
   FROM ((public.managers m
     JOIN public.departments d ON (((m.dept_no)::text = (d.dept_no)::text)))
     JOIN public.employees e ON ((m.emp_no = e.emp_no)));


ALTER TABLE public.vw_dept_managers OWNER TO postgres;

--
-- Name: vw_emp_hercules_b; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_hercules_b AS
 SELECT employees.first_name,
    employees.last_name,
    employees.sex
   FROM public.employees
  WHERE (((employees.first_name)::text = 'Hercules'::text) AND ((employees.last_name)::text ~~ 'B%'::text));


ALTER TABLE public.vw_emp_hercules_b OWNER TO postgres;

--
-- Name: vw_emp_hired_1986; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_hired_1986 AS
 SELECT employees.first_name,
    employees.last_name,
    employees.hire_date
   FROM public.employees
  WHERE ((employees.hire_date >= '1986-01-01'::date) AND (employees.hire_date <= '1986-12-31'::date));


ALTER TABLE public.vw_emp_hired_1986 OWNER TO postgres;

--
-- Name: vw_emp_last_name_freq; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_last_name_freq AS
 SELECT employees.last_name,
    count(employees.emp_no) AS count
   FROM public.employees
  GROUP BY employees.last_name
  ORDER BY (count(employees.emp_no)) DESC;


ALTER TABLE public.vw_emp_last_name_freq OWNER TO postgres;

--
-- Name: vw_emp_salary; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_salary AS
 SELECT e.emp_no,
    e.last_name,
    e.first_name,
    e.sex,
    s.salary
   FROM (public.employees e
     JOIN public.salaries s ON ((e.emp_no = s.emp_no)));


ALTER TABLE public.vw_emp_salary OWNER TO postgres;

--
-- Name: vw_emp_sales_dept; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_sales_dept AS
 SELECT e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp_numbers de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((d.dept_no)::text = (de.dept_no)::text)))
  WHERE ((d.dept_name)::text = 'Sales'::text);


ALTER TABLE public.vw_emp_sales_dept OWNER TO postgres;

--
-- Name: vw_emp_sales_dev_dept; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.vw_emp_sales_dev_dept AS
 SELECT e.emp_no,
    e.last_name,
    e.first_name,
    d.dept_name
   FROM ((public.employees e
     JOIN public.dept_emp_numbers de ON ((e.emp_no = de.emp_no)))
     JOIN public.departments d ON (((d.dept_no)::text = (de.dept_no)::text)))
  WHERE (((d.dept_name)::text = 'Sales'::text) OR ((d.dept_name)::text = 'Development'::text));


ALTER TABLE public.vw_emp_sales_dev_dept OWNER TO postgres;

--
-- Name: departments departments_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.departments
    ADD CONSTRAINT departments_pkey PRIMARY KEY (dept_no);


--
-- Name: dept_emp_numbers dept_emp_numbers_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp_numbers
    ADD CONSTRAINT dept_emp_numbers_pkey PRIMARY KEY (dept_no, emp_no);


--
-- Name: employees employees_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.employees
    ADD CONSTRAINT employees_pkey PRIMARY KEY (emp_no);


--
-- Name: salaries salaries_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT salaries_pkey PRIMARY KEY (emp_no);


--
-- Name: titles titles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.titles
    ADD CONSTRAINT titles_pkey PRIMARY KEY (title_id);


--
-- Name: dept_emp_numbers fk_dept_emp_dept_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp_numbers
    ADD CONSTRAINT fk_dept_emp_dept_no FOREIGN KEY (dept_no) REFERENCES public.departments(dept_no);


--
-- Name: dept_emp_numbers fk_dept_emp_emp_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.dept_emp_numbers
    ADD CONSTRAINT fk_dept_emp_emp_no FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- Name: managers fk_dept_manager_emp_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.managers
    ADD CONSTRAINT fk_dept_manager_emp_no FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- Name: salaries fk_salaries_emp_no; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.salaries
    ADD CONSTRAINT fk_salaries_emp_no FOREIGN KEY (emp_no) REFERENCES public.employees(emp_no);


--
-- PostgreSQL database dump complete
--

