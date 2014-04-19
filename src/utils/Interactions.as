package utils 
{
	import nape.callbacks.CbType;
	import nape.callbacks.InteractionCallback;
	import nape.phys.Interactor;
	/**
	 * Interactions manager, contains callback handlers for different collision types
	 * @author Hammerzeit
	 */
	public class Interactions 
	{
		private static var _instance:Interactions;
		
		public var CBTYPE_STATIC_RECT:CbType;
		public var CBTYPE_STATIC_CIRCLE:CbType;
		public var CBTYPE_DYNAMIC_RECT:CbType;
		public var CBTYPE_DYNAMIC_CIRCLE:CbType;
		
		static public function get instance():Interactions 
		{
			if ( !_instance )
				_instance = new Interactions( new SingletonEnforcer() );
			return _instance;
		}
		
		public function Interactions(singletonEnforcer:SingletonEnforcer) 
		{
			if ( !singletonEnforcer )
				throw new Error("Nigga, Interactions class is singleton, refer to it by it's instance static property, not new operator");
			else
			{
				CBTYPE_STATIC_RECT = new CbType();
				CBTYPE_DYNAMIC_RECT = new CbType();
				CBTYPE_DYNAMIC_CIRCLE = new CbType();
				CBTYPE_STATIC_CIRCLE = new CbType();
			} 
		}       
	   
		public function beginHandler(cb:InteractionCallback):void 
		{
			var firstObject:Interactor = cb.int1;
			var secondObject:Interactor = cb.int2;		
			
			var dataA:* = firstObject.userData;
			var dataB:* = secondObject.userData;
			
			if ( dataA &&  dataA.hasOwnProperty("type") )
				var stat:* = dataA.type == "dynamic" ? dataA : null;
			if ( dataB &&  dataB.hasOwnProperty("type") )
				stat = dataB.type == "dynamic" ? dataB : stat;
				
			if (stat)
			{
				stat["inAir"] = false;
			}
		}
		
		public function ongoingHandler(cb:InteractionCallback):void 
		{
			var firstObject:Interactor = cb.int1;
			var secondObject:Interactor = cb.int2;
			
			var dataA:* = firstObject.userData;
			var dataB:* = secondObject.userData;
			
			if ( dataA &&  dataA.hasOwnProperty("type") )
				var stat:* = dataA.type == "dynamic" ? dataA : null;
			if ( dataB &&  dataB.hasOwnProperty("type") )
				stat = dataB.type == "dynamic" ? dataB : stat;
				
			if (stat)
			{
				stat["inAir"] = false;
			}
		}
		
		public function endHandler(cb:InteractionCallback):void 
		{
			var firstObject:Interactor = cb.int1;
			var secondObject:Interactor = cb.int2;	
			
			var dataA:* = firstObject.userData;
			var dataB:* = secondObject.userData;
			
			if ( dataA  )
				var stat:* = dataA.type == "dynamic" ? dataA : null;
			if ( dataB  )
				stat = dataB.type == "dynamic" ? dataB : stat;
			
			if (stat)
			{
				stat["inAir"] = true;
			}
		}
		
	}

}

class SingletonEnforcer
{	
}