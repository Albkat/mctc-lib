! This file is part of mctc-lib.
!
! Licensed under the Apache License, Version 2.0 (the "License");
! you may not use this file except in compliance with the License.
! You may obtain a copy of the License at
!
!     http://www.apache.org/licenses/LICENSE-2.0
!
! Unless required by applicable law or agreed to in writing, software
! distributed under the License is distributed on an "AS IS" BASIS,
! WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
! See the License for the specific language governing permissions and
! limitations under the License.

module test_read_genformat
   use mctc_env_testing, only : new_unittest, unittest_type, error_type, check
   use mctc_io_read_genformat
   use mctc_io_structure
   implicit none
   private

   public :: collect_read_genformat


contains


!> Collect all exported unit tests
subroutine collect_read_genformat(testsuite)

   !> Collection of tests
   type(unittest_type), allocatable, intent(out) :: testsuite(:)

   testsuite = [ &
      & new_unittest("valid1-gen", test_valid1_gen), &
      & new_unittest("valid2-gen", test_valid2_gen), &
      & new_unittest("valid3-gen", test_valid3_gen), &
      & new_unittest("valid4-gen", test_valid4_gen), &
      & new_unittest("invalid1-gen", test_invalid1_gen, should_fail=.true.), &
      & new_unittest("invalid2-gen", test_invalid2_gen, should_fail=.true.), &
      & new_unittest("invalid3-gen", test_invalid3_gen, should_fail=.true.), &
      & new_unittest("invalid4-gen", test_invalid4_gen, should_fail=.true.), &
      & new_unittest("invalid5-gen", test_invalid5_gen, should_fail=.true.), &
      & new_unittest("invalid6-gen", test_invalid6_gen, should_fail=.true.) &
      & ]

end subroutine collect_read_genformat


subroutine test_valid1_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "3 C", &
      "O H", &
      "# B3LYP geometry", &
      "1 1 0.00000 0.00000 0.11974", &
      "2 2 0.00000 0.76158 -0.47898", &
      "2 2 0.00000 -0.76158 -0.47898"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

   call check(error, struc%nat, 3, "Number of atoms does not match")
   if (allocated(error)) return
   call check(error, struc%nid, 2, "Number of species does not match")
   if (allocated(error)) return

end subroutine test_valid1_gen


subroutine test_valid2_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "9 C", &
      "C Br H O", &
      "     1   1  -8.9147060000E-02  -6.6786080000E-02  -1.0432907000E-01", &
      "     2   2   1.7639746700E+00   2.6771621000E-01   4.2178865000E-01", &
      "     3   3  -2.6325805000E-01  -1.1300550700E+00  -1.3052621000E-01", &
      "     4   3  -7.4963702000E-01   3.9302570000E-01   6.1238499000E-01", &
      "     5   3  -2.6130022000E-01   3.5462634000E-01  -1.0812232600E+00", &
      "     6   4   4.7684499800E+00   7.6734388000E-01   1.2078966200E+00", &
      "     7   1   5.5165496700E+00   2.5437564000E-01   4.3331738000E-01", &
      "     8   3   6.6378745000E+00   3.1585526000E-01   5.3760272000E-01", &
      "     9   3   5.1708208600E+00  -3.3263252000E-01  -4.6451965000E-01"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

   call check(error, struc%nat, 9, "Number of atoms does not match")
   if (allocated(error)) return
   call check(error, struc%nid, 4, "Number of species does not match")
   if (allocated(error)) return

end subroutine test_valid2_gen


subroutine test_valid3_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "8 S", &
      "C", &
      "     1   1   0.0000000000E+00   0.0000000000E+00   0.0000000000E+00", &
      "     2   1  -0.0000000000E+00   1.7833900000E+00   1.7834000000E+00", &
      "     3   1   1.7833900000E+00   1.7834000000E+00   0.0000000000E+00", &
      "     4   1   1.7833900000E+00  -0.0000000000E+00   1.7834000000E+00", &
      "     5   1   2.6750900000E+00   8.9170000000E-01   2.6750900000E+00", &
      "     6   1   8.9170000000E-01   8.9170000000E-01   8.9170000000E-01", &
      "     7   1   8.9170000000E-01   2.6750900000E+00   2.6750900000E+00", &
      "     8   1   2.6750900000E+00   2.6750900000E+00   8.9170000000E-01", &
      "0.0 0.0 0.0", &
      "3.567 0.0 0.0", &
      "0.0 3.567 0.0", &
      "0.0 0.0 3.567"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

   call check(error, struc%nat, 8, "Number of atoms does not match")
   if (allocated(error)) return
   call check(error, struc%nid, 1, "Number of species does not match")
   if (allocated(error)) return

end subroutine test_valid3_gen


subroutine test_valid4_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  F", &
      "Ga As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25", &
      "0.0000000E+00 0.0000000E+00 0.0000000E+00", &
      "0.2713546E+01 0.2713546E+01 0.0000000E+00", &
      "0.0000000E+00 0.2713546E+01 0.2713546E+01", &
      "0.2713546E+01 0.0000000E+00 0.2713546E+01"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

   call check(error, struc%nat, 2, "Number of atoms does not match")
   if (allocated(error)) return
   call check(error, struc%nid, 2, "Number of species does not match")
   if (allocated(error)) return

end subroutine test_valid4_gen


subroutine test_invalid1_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "-2  F", &
      "Ga As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25", &
      "0.0000000E+00 0.0000000E+00 0.0000000E+00", &
      "0.2713546E+01 0.2713546E+01 0.0000000E+00", &
      "0.0000000E+00 0.2713546E+01 0.2713546E+01", &
      "0.2713546E+01 0.0000000E+00 0.2713546E+01"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid1_gen


subroutine test_invalid2_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  X", &
      "Ga As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25", &
      "0.0000000E+00 0.0000000E+00 0.0000000E+00", &
      "0.2713546E+01 0.2713546E+01 0.0000000E+00", &
      "0.0000000E+00 0.2713546E+01 0.2713546E+01", &
      "0.2713546E+01 0.0000000E+00 0.2713546E+01"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid2_gen


subroutine test_invalid3_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  F", &
      "Ga ***As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25", &
      "0.0000000E+00 0.0000000E+00 0.0000000E+00", &
      "0.2713546E+01 0.2713546E+01 0.0000000E+00", &
      "0.0000000E+00 0.2713546E+01 0.2713546E+01", &
      "0.2713546E+01 0.0000000E+00 0.2713546E+01"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid3_gen


subroutine test_invalid4_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  F", &
      "Ga As"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid4_gen


subroutine test_invalid5_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  F", &
      "Ga As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid5_gen


subroutine test_invalid6_gen(error)

   !> Error handling
   type(error_type), allocatable, intent(out) :: error

   type(structure_type) :: struc
   integer :: unit

   open(status='scratch', newunit=unit)
   write(unit, '(a)') &
      "2  F", &
      "Ga As", &
      "1 1 0.00 0.00 0.00", &
      "2 2 0.25 0.25 0.25", &
      "0.0000000E+00 0.0000000E+00 0.0000000E+00", &
      "************* ************* 0.0000000E+00", &
      "0.0000000E+00 ************* *************", &
      "************* 0.0000000E+00 *************"
   rewind(unit)

   call read_genformat(struc, unit, error)
   close(unit)
   if (allocated(error)) return

end subroutine test_invalid6_gen


end module test_read_genformat
