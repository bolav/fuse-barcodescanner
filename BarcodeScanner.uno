using Uno;
using Uno.UX;
using Uno.Collections;
using Fuse;
using Fuse.Controls;
public class BarcodeScanner : Panel
{
	public event ValueChangedHandler<string> CodeChanged;

	[UXValueChangedEvent("SetCode", "CodeChanged")]
	public string Code {
		get;
		set;
	}
	public void SetCode(string value, object origin)
	{
		Code = value;
		OnCodeChanged(value, origin);
	}

	void OnCodeChanged(string value, object orig)
	{
		if (CodeChanged != null) {
			CodeChanged(this, new ValueChangedArgs<string>(value, orig));
		}
	}

}
