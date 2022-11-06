# ABAP List Viewer with MVC Concept by using CL_SALV_TABLE 
## Overview
This MVC concept was implemented by using class CL_SALV_TABLE and also make it editable that was released after 756. The editable of SALV concept was followed by link: https://blogs.sap.com/2022/08/01/editable-cl_salv_table-after-release-756

## Framework architecture
The framework consists of the following repo objects:
  1. The main controller class ZCL_MVCFW_BASE_CONTROLLER. A program will define its own main controller inheriting from this class.
  2. The ABAP List Viewer(ALV) class ZCL_MVCFW_BASE_SALV_VIEW. A program will display report as ALV that was called by class CL_SALV_TABLE.
  3. The model class ZCL_MVCFW_BASE_MODEL. A program will define its own main model inheriting from this class to manipulate any data.
  4. The screen class ZCL_MVCFW_BASE_SSCR. It will manipulate selection screen that handle via PBO and PAI.  
  5. The exception class ZBCX_EXCEPTION. It will be thrown any errors into this exception class.

## Demo application

The report YDEMO_APP is a sample application with a simple dynpro and two ALV grids in it.

![image](https://user-images.githubusercontent.com/57941447/200183813-4b2f9699-4a11-494a-9dd1-7c0e754c7304.png)

If the program was double click to any row, it will deep-down into second ALV grids. 

![image](https://user-images.githubusercontent.com/57941447/200185986-353b7912-4894-4f08-a73b-dffae2ae6e99.png)
![image](https://user-images.githubusercontent.com/57941447/200185956-66ded94b-48d2-4cd3-a9d5-067e001a2e7e.png)
