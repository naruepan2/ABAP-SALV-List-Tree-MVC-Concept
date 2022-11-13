# ABAP List/Tree Viewer with MVC Concept with class CL_SALV_TABLE and CL_SALV_TREE after released 756 (Only support SAP release 756 or above)
## Overview
This MVC concept was implemented Object Oriented ALV (OO ALV) by using class CL_SALV_TABLE and also make it editable that was released after 756. The editable of SALV concept was followed by link: https://blogs.sap.com/2022/08/01/editable-cl_salv_table-after-release-756
Moreover, it also support SALV Tree by using class CL_SALV_TREE.

For Quickstart Snippets. You can follow SALV tutorial via links as below:
 - https://blogs.sap.com/2021/06/28/salv-alv-quickstart-snippets
 - http://zevolving.com/category/salv-tutorial/salv-table

## Framework architecture
The framework consists of the following repo objects:
  1. The main controller class ZCL_MVCFW_BASE_CONTROLLER. A program will define its own main controller inheriting from this class.
  2. Interface class ZIF_MVCFW_BASE_SALV_VIEW for ZCL_MVCFW_BASE_SALV_LIST_VIEW and ZCL_MVCFW_BASE_SALV_TREE_VIEW
  3. The Simple ABAP List Viewer(SALV) class ZCL_MVCFW_BASE_SALV_LIST_VIEW. A program will display report as ALV that was called by class CL_SALV_TABLE.
  4. The Simple ABAP List Viewer Tree(SALV Tree) class ZCL_MVCFW_BASE_SALV_TREE_VIEW. A program will display report as ALV that was called by class CL_SALV_TREE.
  5. The model class ZCL_MVCFW_BASE_MODEL. A program will define its own main model inheriting from this class to manipulate any data of this model.
  6. The screen class ZCL_MVCFW_BASE_SSCR. It will manipulate selection screen that handle the PBO, PAI and so on.  
  7. The exception class ZBCX_EXCEPTION. It will be thrown any errors into this exception class.

## Demo application for SALV List

The report YDEMO_SALV_LIST_APP is a sample application with a simple dynpro and two ALV grids/list in it.

![image](https://user-images.githubusercontent.com/57941447/200183813-4b2f9699-4a11-494a-9dd1-7c0e754c7304.png)

If the program was double click to any row, it will deep-down into second ALV grids. 

![image](https://user-images.githubusercontent.com/57941447/200185986-353b7912-4894-4f08-a73b-dffae2ae6e99.png)
![image](https://user-images.githubusercontent.com/57941447/200185956-66ded94b-48d2-4cd3-a9d5-067e001a2e7e.png)

## Demo application for SALV Tree
The report YDEMO_SALV_TREE_APP is a sample application with a simple dynpro with ALV tree.

![image](https://user-images.githubusercontent.com/57941447/201536070-331879f1-0ac5-4aaf-8c12-8e0598c47157.png)



