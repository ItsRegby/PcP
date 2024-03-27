pragma Warnings (Off);
pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__main.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__main.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is

   E063 : Short_Integer; pragma Import (Ada, E063, "system__os_lib_E");
   E014 : Short_Integer; pragma Import (Ada, E014, "ada__exceptions_E");
   E010 : Short_Integer; pragma Import (Ada, E010, "system__soft_links_E");
   E008 : Short_Integer; pragma Import (Ada, E008, "system__exception_table_E");
   E005 : Short_Integer; pragma Import (Ada, E005, "ada__containers_E");
   E059 : Short_Integer; pragma Import (Ada, E059, "ada__io_exceptions_E");
   E044 : Short_Integer; pragma Import (Ada, E044, "ada__strings_E");
   E046 : Short_Integer; pragma Import (Ada, E046, "ada__strings__maps_E");
   E050 : Short_Integer; pragma Import (Ada, E050, "ada__strings__maps__constants_E");
   E069 : Short_Integer; pragma Import (Ada, E069, "interfaces__c_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__exceptions_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__object_reader_E");
   E039 : Short_Integer; pragma Import (Ada, E039, "system__dwarf_lines_E");
   E088 : Short_Integer; pragma Import (Ada, E088, "system__soft_links__initialize_E");
   E030 : Short_Integer; pragma Import (Ada, E030, "system__traceback__symbolic_E");
   E118 : Short_Integer; pragma Import (Ada, E118, "ada__numerics_E");
   E099 : Short_Integer; pragma Import (Ada, E099, "ada__strings__utf_encoding_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "ada__tags_E");
   E097 : Short_Integer; pragma Import (Ada, E097, "ada__strings__text_buffers_E");
   E159 : Short_Integer; pragma Import (Ada, E159, "gnat_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "interfaces__c__strings_E");
   E095 : Short_Integer; pragma Import (Ada, E095, "ada__streams_E");
   E158 : Short_Integer; pragma Import (Ada, E158, "system__file_control_block_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "system__finalization_root_E");
   E093 : Short_Integer; pragma Import (Ada, E093, "ada__finalization_E");
   E157 : Short_Integer; pragma Import (Ada, E157, "system__file_io_E");
   E191 : Short_Integer; pragma Import (Ada, E191, "system__storage_pools_E");
   E189 : Short_Integer; pragma Import (Ada, E189, "system__finalization_masters_E");
   E200 : Short_Integer; pragma Import (Ada, E200, "system__storage_pools__subpools_E");
   E143 : Short_Integer; pragma Import (Ada, E143, "system__task_info_E");
   E197 : Short_Integer; pragma Import (Ada, E197, "ada__calendar_E");
   E120 : Short_Integer; pragma Import (Ada, E120, "ada__real_time_E");
   E153 : Short_Integer; pragma Import (Ada, E153, "ada__text_io_E");
   E195 : Short_Integer; pragma Import (Ada, E195, "system__random_seed_E");
   E173 : Short_Integer; pragma Import (Ada, E173, "system__tasking__initialization_E");
   E163 : Short_Integer; pragma Import (Ada, E163, "system__tasking__protected_objects_E");
   E169 : Short_Integer; pragma Import (Ada, E169, "system__tasking__protected_objects__entries_E");
   E181 : Short_Integer; pragma Import (Ada, E181, "system__tasking__queuing_E");
   E161 : Short_Integer; pragma Import (Ada, E161, "gnat__semaphores_E");
   E213 : Short_Integer; pragma Import (Ada, E213, "system__tasking__stages_E");

   Sec_Default_Sized_Stacks : array (1 .. 1) of aliased System.Secondary_Stack.SS_Stack (System.Parameters.Runtime_Default_Sec_Stack_Size);

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E169 := E169 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E153 := E153 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      E200 := E200 - 1;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__storage_pools__subpools__finalize_spec");
      begin
         F3;
      end;
      E189 := E189 - 1;
      declare
         procedure F4;
         pragma Import (Ada, F4, "system__finalization_masters__finalize_spec");
      begin
         F4;
      end;
      declare
         procedure F5;
         pragma Import (Ada, F5, "system__file_io__finalize_body");
      begin
         E157 := E157 - 1;
         F5;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (Ada, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;
   pragma Favor_Top_Level (No_Param_Proc);

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Default_Secondary_Stack_Size : System.Parameters.Size_Type;
      pragma Import (C, Default_Secondary_Stack_Size, "__gnat_default_ss_size");
      Bind_Env_Addr : System.Address;
      pragma Import (C, Bind_Env_Addr, "__gl_bind_env_addr");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
      Binder_Sec_Stacks_Count : Natural;
      pragma Import (Ada, Binder_Sec_Stacks_Count, "__gnat_binder_ss_count");
      Default_Sized_SS_Pool : System.Address;
      pragma Import (Ada, Default_Sized_SS_Pool, "__gnat_default_ss_pool");

   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (True, False, False, False, True, True, False, False, 
           True, False, False, True, True, True, True, False, 
           False, False, False, True, False, False, True, True, 
           False, True, True, False, True, True, True, True, 
           False, False, False, False, False, True, False, True, 
           True, False, True, False, True, True, False, False, 
           False, True, False, False, True, True, False, True, 
           False, False, False, True, False, False, True, False, 
           True, True, True, True, False, True, False, True, 
           True, True, False, True, True, False, True, True, 
           True, True, False, False, False, True, False, False, 
           False, False, True, False, True, True, False, True, 
           False),
         Count => (0, 0, 0, 1, 0, 1, 1, 0, 1, 0),
         Unknown => (False, False, False, False, False, False, True, False, True, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;

      ada_main'Elab_Body;
      Default_Secondary_Stack_Size := System.Parameters.Runtime_Default_Sec_Stack_Size;
      Binder_Sec_Stacks_Count := 1;
      Default_Sized_SS_Pool := Sec_Default_Sized_Stacks'Address;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      Ada.Exceptions'Elab_Spec;
      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E008 := E008 + 1;
      Ada.Containers'Elab_Spec;
      E005 := E005 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E059 := E059 + 1;
      Ada.Strings'Elab_Spec;
      E044 := E044 + 1;
      Ada.Strings.Maps'Elab_Spec;
      E046 := E046 + 1;
      Ada.Strings.Maps.Constants'Elab_Spec;
      E050 := E050 + 1;
      Interfaces.C'Elab_Spec;
      E069 := E069 + 1;
      System.Exceptions'Elab_Spec;
      E017 := E017 + 1;
      System.Object_Reader'Elab_Spec;
      E071 := E071 + 1;
      System.Dwarf_Lines'Elab_Spec;
      E039 := E039 + 1;
      System.Os_Lib'Elab_Body;
      E063 := E063 + 1;
      System.Soft_Links.Initialize'Elab_Body;
      E088 := E088 + 1;
      E010 := E010 + 1;
      System.Traceback.Symbolic'Elab_Body;
      E030 := E030 + 1;
      E014 := E014 + 1;
      Ada.Numerics'Elab_Spec;
      E118 := E118 + 1;
      Ada.Strings.Utf_Encoding'Elab_Spec;
      E099 := E099 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Tags'Elab_Body;
      E105 := E105 + 1;
      Ada.Strings.Text_Buffers'Elab_Spec;
      Ada.Strings.Text_Buffers'Elab_Body;
      E097 := E097 + 1;
      Gnat'Elab_Spec;
      E159 := E159 + 1;
      Interfaces.C.Strings'Elab_Spec;
      E126 := E126 + 1;
      Ada.Streams'Elab_Spec;
      E095 := E095 + 1;
      System.File_Control_Block'Elab_Spec;
      E158 := E158 + 1;
      System.Finalization_Root'Elab_Spec;
      System.Finalization_Root'Elab_Body;
      E115 := E115 + 1;
      Ada.Finalization'Elab_Spec;
      E093 := E093 + 1;
      System.File_Io'Elab_Body;
      E157 := E157 + 1;
      System.Storage_Pools'Elab_Spec;
      E191 := E191 + 1;
      System.Finalization_Masters'Elab_Spec;
      System.Finalization_Masters'Elab_Body;
      E189 := E189 + 1;
      System.Storage_Pools.Subpools'Elab_Spec;
      System.Storage_Pools.Subpools'Elab_Body;
      E200 := E200 + 1;
      System.Task_Info'Elab_Spec;
      E143 := E143 + 1;
      Ada.Calendar'Elab_Spec;
      Ada.Calendar'Elab_Body;
      E197 := E197 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E120 := E120 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E153 := E153 + 1;
      System.Random_Seed'Elab_Body;
      E195 := E195 + 1;
      System.Tasking.Initialization'Elab_Body;
      E173 := E173 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E163 := E163 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E169 := E169 + 1;
      System.Tasking.Queuing'Elab_Body;
      E181 := E181 + 1;
      E161 := E161 + 1;
      System.Tasking.Stages'Elab_Body;
      E213 := E213 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_main");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      if gnat_argc = 0 then
         gnat_argc := argc;
         gnat_argv := argv;
      end if;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   D:\Git\PcP\Lab3\Lab3_PcP_Ada\obj\main.o
   --   -LD:\Git\PcP\Lab3\Lab3_PcP_Ada\obj\
   --   -LD:\Git\PcP\Lab3\Lab3_PcP_Ada\obj\
   --   -LD:/programs/gnat/2021/lib/gcc/x86_64-w64-mingw32/10.3.1/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -Xlinker
   --   --stack=0x200000,0x1000
   --   -mthreads
   --   -Wl,--stack=0x2000000
--  END Object file/option list   

end ada_main;
