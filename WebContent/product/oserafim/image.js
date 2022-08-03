String.prototype.trim = function() {
		var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
		return this.replace(TRIM_PATTERN, "");
}

function sendIt() {
    f = document.myForm;
    
    str = f.productNum.value;
    str = str.trim();
    if(!str) {
        alert("※제품코드 입력");
        f.productNum.focus();
        return;
    }
    f.productNum.value = str;
    
    str = f.productName.value;
    str = str.trim();
    if(!str) {
        alert("※제품명 입력");
        f.productName.focus();
        return;
    }
    f.productName.value = str;
    
    str = f.price.value;
    str = str.trim();
    if(!str) {
        alert("※가격 입력");
        f.price.focus();
        return;
    }
    f.price.value = str;
    
    str = f.content.value;
    str = str.trim();
    if(!str) {
        alert("※설명 입력");
        f.content.focus();
        return;
    }
    f.content.value = str;
    
    str = f.upload.value;
    if(!str) {
        alert("※이미지 파일 선택");
        f.upload.focus();
        return;
    }
    
    f.action="/study/pdct/write_ok.do";
    f.submit();
}

function readURL(input) {
	  if (input.files && input.files[0]) {
	    var reader = new FileReader();
	    reader.onload = function(e) {
	      document.getElementById('preview').src = e.target.result;
	    };
	    reader.readAsDataURL(input.files[0]);
	  } else {
	    document.getElementById('preview').src = "";
	  }
}
