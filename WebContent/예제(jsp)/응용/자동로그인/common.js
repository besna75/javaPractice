//<script>
//####	���� ���̺귯��	####
/**************************************
* ���ϸ�: common.js
* ���: ���� ���̺귯��
* �ۼ���: 2002-07-04
* �ۼ���: ��ģ����
* ����: �ϱ�ȣ
***************************************/

/** boolean validate(object form)
* �ش� ���� �Է� ������ �����ϴ����� ���� �������� ������� 
* ���â�� �����ְ� Ŀ�� ��Ŀ���� �̵��ϸ� false �� �����Ͽ� submit �� ���´�
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
	var regHangul =/[��-�R]/;
	var regHangulOnly =/^[��-�R ]*$/;
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
			alert(name + "�� ������ �ùٸ��� �ʽ��ϴ�");
			break;
		case "phone":
			alert(name + "�� ������ �ùٸ��� �ʽ��ϴ�");
			break;
		case "hangul":
			alert(name + " �׸� �ѱ��� ���ԵǾ����� �ʽ��ϴ�");
			break;
		case "alnumonly":
			alert(name + " �׸��� ���� �Ǵ� ���ڸ� ������ �� �ֽ��ϴ�.");
			break;
		case "numberonly":
			alert(name + " �׸��� ���ڸ� ������ �� �ֽ��ϴ�.");
			break;
		default:
			alert(name + " �׸��� �ݵ�� �Է��ؾ� �մϴ�");
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