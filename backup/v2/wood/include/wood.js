function removeItemFromCart(prodId)
{
	document.frm.hdnRemoveProd.value = prodId;
	document.frm.submit();	
}

function cancelOrder()
{  
	if( confirm("Are you sure you want to cancel the order?") )
	{
		document.frm.hdnCancelOrder.value = "CANCELORDER";
		document.frm.action = "index.jsp";
		document.frm.submit();
	}	
}


function updateShipAddress()
{
	document.frm.txtShipAddress1.value = document.frm.txtAddress1.value;
	document.frm.txtShipAddress2.value = document.frm.txtAddress2.value;
	document.frm.txtShipCity.value = document.frm.txtCity.value;
	document.frm.txtShipZip.value = document.frm.txtZip.value;
	document.frm.slShipState.selectedIndex  = document.frm.slState.selectedIndex;
	
}

function createAccountSubmit()
{
	if( document.frm.txtPassword.value == document.frm.txtConfPassword.value )
		document.frm.submit();
	else
		alert("Password and Confirm password do not match.  Please re-enter.");  
}

function onAddToCart(prodId, item)
{
	document.frm.hdnOp.value = "ADD";
	document.frm.prod.value = prodId;
	document.frm.hdnItem.value = item;
	document.frm.submit();	
}





