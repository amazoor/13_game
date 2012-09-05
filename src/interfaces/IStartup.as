package interfaces
{
	public interface IStartup
	{
		function callAdminPanel()				:void;
		function setPause(value:Boolean)		:void;
		function start(flashVars:Object = null)	:void;
		function ready(flashVars:Object = null)	:void;
	}
}