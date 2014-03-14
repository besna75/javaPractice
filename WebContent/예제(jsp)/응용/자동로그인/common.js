//<script>
//####	°øÅë ¶óÀÌºê·¯¸®	####
/**************************************
* ÆÄÀÏ¸í: common.js
* ±â´É: °øÅë ¶óÀÌºê·¯¸®
* ÀÛ¼ºÀÏ: 2002-07-04
* ÀÛ¼ºÀÚ: °ÅÄ£¸¶·ç
* ¼öÁ¤: ÇÏ±ÙÈ£
***************************************/

/** boolean validate(object form)
* ÇØ´ç ÆûÀÇ ÀÔ·Â Á¶°ÇÀÌ ¸¸Á·ÇÏ´ÂÁö¿¡ µû¶ó ¸¸Á·ÇÏÁö ¾ÊÀ»°æ¿ì 
* °æ°íÃ¢À» º¸¿©ÁÖ°í Ä¿¼­ Æ÷Ä¿½º¸¦ ÀÌµ¿ÇÏ¸ç false ¸¦ ¸®ÅÏÇÏ¿© submit À» ¸·´Â´Ù
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
	var regHangul =/[°¡-ÆR]/;
	var regHangulOnly =/^[°¡-ÆR ]*$/;
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
			alert(name + "ÀÇ Çü½ÄÀÌ ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù");
			break;
		case "phone":
			alert(name + "ÀÇ Çü½ÄÀÌ ¿Ã¹Ù¸£Áö ¾Ê½À´Ï´Ù");
			break;
		case "hangul":
			alert(name + " Ç×¸ñ¿¡ ÇÑ±ÛÀÌ Æ÷ÇÔµÇ¾îÀÖÁö ¾Ê½À´Ï´Ù");
			break;
		case "alnumonly":
			alert(name + " Ç×¸ñÀº ¿µ¹® ¶Ç´Â ¼ıÀÚ¸¸ Àû¿ëÇÒ ¼ö ÀÖ½À´Ï´Ù.");
			break;
		case "numberonly":
			alert(name + " Ç×¸ñÀº ¼ıÀÚ¸¸ Àû¿ëÇÒ ¼ö ÀÖ½À´Ï´Ù.");
			break;
		default:
			alert(name + " Ç×¸ñÀº ¹İµå½Ã ÀÔ·ÂÇØ¾ß ÇÕ´Ï´Ù");
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