//<script>
//####	공통 라이브러리	####
/**************************************
* 파일명: common.js
* 기능: 공통 라이브러리
* 작성일: 2002-07-04
* 작성자: 거친마루
* 수정: 하근호
***************************************/

/** boolean validate(object form)
* 해당 폼의 입력 조건이 만족하는지에 따라 만족하지 않을경우 
* 경고창을 보여주고 커서 포커스를 이동하며 false 를 리턴하여 submit 을 막는다
*/
function validate(form)	{
	var regNum =/^[0-9]+$/;
	var regPhone =/^[0-9]{2,3}-[0-9]{3,4}-[0-9]{3,4}$/;
	var regMail =/^[_a-zA-Z0-9-]+@[\._a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	var regDomain =/^[\.a-zA-Z0-9-]+\.[a-zA-Z]+$/;
	var regAlpha =/^[a-zA-Z]+$/;
	var regAlnumOnly =/^[a-zA-Z0-9]*$/;
	var regNumberOnly =/^[0-9]*$/;
	var regHost =/^[a-zA-Z-]+$/;
	var regHangul =/[가-힣]/;
	var regHangulOnly =/^[가-힣 ]*$/;
	for (i = 0; i < form.elements.length; i++ )	{
		var currEl = form.elements[i];
		if (currEl.getAttribute("required") != null)	{
			if (currEl.value == "")	{
				return do_error(currEl);
			}
		}
		if (currEl.getAttribute("option") != null && currEl.value != "")	{
			if (currEl.option == "email" && !regMail.test(currEl.value))	{
				return do_error(currEl,"mail");
			}
			if (currEl.option == "phone" && !regPhone.test(currEl.value))	{
				return do_error(currEl,"phone");
			}
			if (currEl.option == "hangul" && !regHangul.test(currEl.value))	{
				return do_error(currEl,"hangul");
			}
			if (currEl.option == "alnumonly" && !regAlnumOnly.test(currEl.value))	{
				return do_error(currEl,"alnumonly");
			}
			if (currEl.option == "numberonly" && !regNumberOnly.test(currEl.value))	{
				return do_error(currEl,"numberonly");
			}
		}
	}
}


function do_error(el,type)	{
	name = (el.hname) ? el.hname : el.name;
	switch (type)	{
		case "mail":
			alert(name + "의 형식이 올바르지 않습니다");
			break;
		case "phone":
			alert(name + "의 형식이 올바르지 않습니다");
			break;
		case "hangul":
			alert(name + " 항목에 한글이 포함되어있지 않습니다");
			break;
		case "alnumonly":
			alert(name + " 항목은 영문 또는 숫자만 적용할 수 있습니다.");
			break;
		case "numberonly":
			alert(name + " 항목은 숫자만 적용할 수 있습니다.");
			break;
		default:
			alert(name + " 항목은 반드시 입력해야 합니다");
			break;
	}
	el.focus();
	return false;
} 


function checked_it(name,value)	{
	var el = document.all.tags("input");
	for (i = 0 ; i < el.length; i++)	{
		if (el[i].name == name && el[i].value == value)	{
			el[i].checked = true;
		}
	}
}


function selected_it(name,value)	{
	var el = document.all.tags("select");
	for (i = 0; i < el.length; i++)	{
		if (el[i].name == name)	{
			if (el[i].size > 1 && el[i].getAttribute("MULTIPLE") != null )	{
				for (k=0; k < value.length; k++)	{
					alert(value[k]);
					for (j = 0; j < el[i].options.length; j++ ) {
						if (el[i].options[j].value == value[k])	{
							el[i].selectedIndex[++x] = j;
						}
					}
				}
			} else {
				for (j = 0; j < el[i].options.length; j++ )	{
					if (el[i].options[j].value == value)	{
						el[i].selectedIndex = j;
					}
				}
			}
		}
	}
}


function enabled_it(name)	{
	var arr = new Array("input", "select", "textarea");
	for(k=0; k<arr.length; k++)	{
		var el = document.all.tags(arr[k]);
		for (i = 0 ; i < el.length; i++)	{
			if (el[i].name == name)	{
				el[i].disabled = false;
			}
		}
	}
}


function disabled_it(name)	{
	var arr = new Array("input", "select", "textarea");
	for(k=0; k<arr.length; k++) {
		var el = document.all.tags(arr[k]);
		for (i = 0 ; i < el.length; i++) {
			if (el[i].name == name) {
				el[i].disabled = true;
			}
		}
	}
}
//</script>