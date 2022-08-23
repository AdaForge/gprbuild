------------------------------------------------------------------------------
--                                                                          --
--                           GPR PROJECT MANAGER                            --
--                                                                          --
--          Copyright (C) 2001-2019, Free Software Foundation, Inc.         --
--                                                                          --
-- This library is free software;  you can redistribute it and/or modify it --
-- under terms of the  GNU General Public License  as published by the Free --
-- Software  Foundation;  either version 3,  or (at your  option) any later --
-- version. This library is distributed in the hope that it will be useful, --
-- but WITHOUT ANY WARRANTY;  without even the implied warranty of MERCHAN- --
-- TABILITY or FITNESS FOR A PARTICULAR PURPOSE.                            --
--                                                                          --
-- As a special exception under Section 7 of GPL version 3, you are granted --
-- additional permissions described in the GCC Runtime Library Exception,   --
-- version 3.1, as published by the Free Software Foundation.               --
--                                                                          --
-- You should have received a copy of the GNU General Public License and    --
-- a copy of the GCC Runtime Library Exception along with this program;     --
-- see the files COPYING3 and COPYING.RUNTIME respectively.  If not, see    --
-- <http://www.gnu.org/licenses/>.                                          --
--                                                                          --
------------------------------------------------------------------------------

--  This package spec holds version information for the GPR tools.
--
--  It is patched on the fly during builds to match the current version, date
--  and build type. Consider it as a compilable template rather than real
--  source.

package GPR.Version is

   Gpr_Version : constant String := "23.0w";
   --  Static string identifying this version

   Date : constant String := "20220529";

   Current_Year : constant String := "2022";

   type Gnat_Build_Type is (Gnatpro, FSF, GPL);
   --  See Get_Gnat_Build_Type below for the meaning of these values

   Build_Type : constant Gnat_Build_Type := Gnatpro;
   --  Kind of GNAT Build:
   --
   --    FSF
   --       GNAT FSF version. This version of GNAT is part of a Free Software
   --       Foundation release of the GNU Compiler Collection (GCC). The bug
   --       box generated by Comperr gives information on how to report bugs
   --       and list the "no warranty" information.
   --
   --    Gnatpro
   --       GNAT Professional version. This version of GNAT is supported by Ada
   --       Core Technologies. The bug box generated by package Comperr gives
   --       instructions on bug submission that include references to customer
   --       number, gnattracker site etc.
   --
   --    GPL
   --       GNAT GPL Edition. This is a special version of GNAT, released by
   --       Ada Core Technologies and intended for academic users, and free
   --       software developers. The bug box generated by the package Comperr
   --       gives appropriate bug submission instructions that do not reference
   --       customer number etc.

   function Gpr_Version_String (Host : Boolean := True) return String;
   --  Version output when GPRBUILD or its related tools, including
   --  GPRCLEAN, are run (with appropriate verbose option switch set).

   function Free_Software return String;
   --  Text to be displayed by the different GNAT tools when switch --version
   --  is used. This text depends on the GNAT build type.

   function Copyright_Holder return String;
   --  Return the name of the Copyright holder to be displayed by the different
   --  GNAT tools when switch --version is used.

end GPR.Version;
