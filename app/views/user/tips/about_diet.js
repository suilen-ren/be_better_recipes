$("#result").on('click',function(event){
  let age = parseInt($("#age").val());
  let weight = parseInt($("#weight").val());
  let height = parseInt($("#height").val());
  let gender_num = parseInt($("#gender_num").val());
  let activity = parseInt($("#activity").val())
  let base_calorie;
  switch(gender_num){
    case 1:
      base_calorie = 13.397 * weight + 4.799 * height - 5.677 * age + 88.362
      break;
    case 2:
      base_calorie = 9.247 * weight + 3.098 * height - 4.33 * age + 447.593
      break;

  }
  let magni_calorie;
  let magni_protein;
  switch(activity){
    case 1:
      magni_calorie = 1.2;
      magni_protein = 1;
      break;
    case 2:
      magni_calorie = 1.3;
      magni_protein = 1.2;
      break;
    case 3:
      magni_calorie = 1.5;
      magni_protein = 1.5;
      break;
    case 4:
      magni_calorie = 1.7;
      magni_protein = 1.7;
      break;
    case 5:
      magni_calorie = 1.9;
      magni_protein = 2;
      break;
  }
  let total_calorie = magni_calorie * base_calorie
  let fat = (total_calorie * 0.1) / 9
  let protein = weight * magni_protein
  let carbo = (total_calorie * 0.9 - protein * 4) / 4


  if (isNaN(base_calorie)){
    alert("数値を正しく入力してください")
  }else{
    $(".disp_switch").show()
    $("#base_calorie").html(parseInt(base_calorie) + "kcal");
    $("#total_calorie").html(parseInt(total_calorie) + "kcal");
    $("#protein").html(parseInt(protein) + "g");
    $("#fat").html(parseInt(fat) + "g");
    $("#carbo").html(parseInt(carbo) + "g");
  }


})