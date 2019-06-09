
** (Advanced)  
** A PEG Rule.
** 
** Use the common rules declared in `Rules`.
@Js
abstract class Rule {
	** The name of this rule. Only rules with names appear in debug output.
	** Should be legal Fantom identifier (think variable names!).
	Str? 		name {
		set {
			if (!it.chars.first.isAlpha || it.chars.any { !it.isAlphaNum && it != '_' })
				throw ArgErr("Name must be a valid Fantom identifier: $it")
			&name = it
		}
	}
	
	** Disable debugging of this rule if it gets to noisy
	Bool debug			:= true

	@NoDoc
	Bool useInResult	:= true
	
	** Action to be performed upon successful completion of this rule.
	virtual |Str matched|?	action

	** Override to implement Rule logic.
	abstract internal Bool doProcess(PegCtx ctx)
	
	** Returns the PEG expression for this rule. Example:
	** 
	**   [a-zA-Z0-9]
	abstract Str expression()

	** Returns the PEG definition for this rule. Example:
	** 
	**   alphaNum <- [a-zA-Z0-9]
	Str definition() {
		((name == null) ? "" : "${name} <- ") + expression		
	}
	
	** A helpful builder method for setting the action.
	This withAction(|Str|? action) {
		this.action = action
		return this
	}

	** A helpful builder method for setting the name.
	This withName(Str name) {
		this.name = name
		return this
	}
	
	@Operator @NoDoc
	virtual This add(Rule rule) {
		throw Err("${typeof.qname} does not support add()")
	}
	
	@NoDoc
	Str dis() { name ?: expression }

	@NoDoc
	override Str toStr() { dis }  

}
