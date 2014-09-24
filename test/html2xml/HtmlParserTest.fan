using xml

internal class HtmlParserTest : Test {

	Void verifyElemEq(XElem elem, Str xml) {
		act := elem.writeToStr.replace("\n", "")
		exp := XParser(xml.in).parseDoc.root.writeToStr.replace("\n", "")
		verifyEq(act, exp)
	}
	
	Void verifyErrMsg(Type errType, Str errMsg, |Test| c) {
		try {
			c.call(this)
		} catch (Err e) {
			if (!e.typeof.fits(errType)) 
				verifyEq(errType, e.typeof)
			verifyEq(errMsg, e.msg)
			return
		}
		fail("$errType not thrown")
	}
	
}
