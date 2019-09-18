import 'package:dsd/common/business_const.dart';
import 'package:dsd/common/dictionary.dart';

/// Copyright  Shanghai eBest Information Technology Co. Ltd  2019
///  All rights reserved.
///
///  Author:       张国鹏
///  Email:        guopeng.zhang@ebestmobile.com)
///  Date:         2019/9/16 14:43

class ProductTotalInfo {
   int totalPlanCs = 0;
   int totalPlanEa = 0;
   int totalActualCs = 0;
   int totalActualEa = 0;

   void clear(){
    totalPlanCs = 0;
    totalPlanEa = 0;
    totalActualCs = 0;
    totalActualEa = 0;
  }

   bool isEqual(String productUnitValue) {
    if(productUnitValue == ProductUnit.CS_EA){
      return totalPlanCs == totalActualCs && totalPlanEa == totalActualEa;
    }else if (productUnitValue == ProductUnit.CS){
      return totalPlanCs == totalActualCs;
    }else if (productUnitValue == ProductUnit.EA){
      return totalPlanEa == totalActualEa;
    }
    return totalPlanCs == totalActualCs && totalPlanEa == totalActualEa;
  }

   String getPlanShowStr(String productUnitValue){
    if(productUnitValue == ProductUnit.CS_EA){
      return '$totalPlanCs/$totalPlanEa';
    }else if (productUnitValue == ProductUnit.CS){
      return totalPlanCs.toString();
    }else if (productUnitValue == ProductUnit.EA){
      return totalPlanEa.toString();
    }
    return '$totalPlanCs/$totalPlanEa';
  }

   String getActualShowStr(String productUnitValue){
    if(productUnitValue == ProductUnit.CS_EA){
      return '$totalActualCs/$totalActualEa';
    }else if (productUnitValue == ProductUnit.CS){
      return totalActualCs.toString();
    }else if (productUnitValue == ProductUnit.EA){
      return totalActualEa.toString();
    }
    return '$totalActualCs/$totalActualEa';
  }

   String getPlanShowStrByType(String taskType){
    if(taskType == TaskType.EmptyReturn){
      return totalPlanEa.toString();
    }
    return '$totalPlanCs/$totalPlanEa';
  }

   String getActualShowStByType(String taskType){
    if(taskType == TaskType.EmptyReturn){
      return totalActualEa.toString();
    }
    return '$totalActualCs/$totalActualEa';
  }

}
