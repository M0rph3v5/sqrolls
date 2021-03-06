package zpp_nape.constraint;
import zpp_nape.Const;
import zpp_nape.ID;
import zpp_nape.constraint.PivotJoint;
import zpp_nape.constraint.WeldJoint;
import zpp_nape.constraint.UserConstraint;
import zpp_nape.constraint.LineJoint;
import zpp_nape.constraint.DistanceJoint;
import zpp_nape.constraint.AngleJoint;
import zpp_nape.constraint.LinearJoint;
import zpp_nape.constraint.MotorJoint;
import zpp_nape.phys.Interactor;
import zpp_nape.phys.FeatureMix;
import zpp_nape.constraint.PulleyJoint;
import zpp_nape.phys.Material;
import zpp_nape.phys.FluidProperties;
import zpp_nape.phys.Compound;
import zpp_nape.callbacks.OptionType;
import zpp_nape.callbacks.CbSetPair;
import zpp_nape.callbacks.CbType;
import zpp_nape.phys.Body;
import zpp_nape.callbacks.CbSet;
import zpp_nape.callbacks.Listener;
import zpp_nape.geom.GeomPoly;
import zpp_nape.callbacks.Callback;
import zpp_nape.geom.Mat23;
import zpp_nape.geom.ConvexRayResult;
import zpp_nape.geom.Cutter;
import zpp_nape.geom.Ray;
import zpp_nape.geom.Vec2;
import zpp_nape.geom.Convex;
import zpp_nape.geom.MatMath;
import zpp_nape.geom.PartitionedPoly;
import zpp_nape.geom.Triangular;
import zpp_nape.geom.Simplify;
import zpp_nape.geom.AABB;
import zpp_nape.geom.Simple;
import zpp_nape.geom.SweepDistance;
import zpp_nape.geom.Monotone;
import zpp_nape.geom.VecMath;
import zpp_nape.geom.Vec3;
import zpp_nape.geom.MatMN;
import zpp_nape.geom.PolyIter;
import zpp_nape.geom.Collide;
import zpp_nape.geom.Geom;
import zpp_nape.geom.MarchingSquares;
import zpp_nape.shape.Circle;
import zpp_nape.shape.Shape;
import zpp_nape.shape.Edge;
import zpp_nape.space.Broadphase;
import zpp_nape.shape.Polygon;
import zpp_nape.space.SweepPhase;
import zpp_nape.space.DynAABBPhase;
import zpp_nape.dynamics.Contact;
import zpp_nape.space.Space;
import zpp_nape.dynamics.Arbiter;
import zpp_nape.dynamics.InteractionGroup;
import zpp_nape.dynamics.InteractionFilter;
import zpp_nape.dynamics.SpaceArbiterList;
import zpp_nape.util.Array2;
import zpp_nape.util.Lists;
import zpp_nape.util.Debug;
import zpp_nape.util.Flags;
import zpp_nape.util.Queue;
import zpp_nape.util.FastHash;
import zpp_nape.util.RBTree;
import zpp_nape.util.Pool;
import zpp_nape.util.Names;
import zpp_nape.util.Circular;
import zpp_nape.util.Math;
import zpp_nape.util.UserData;
import zpp_nape.util.DisjointSetForest;
import nape.TArray;
import zpp_nape.util.WrapLists;
import nape.Config;
import nape.constraint.PivotJoint;
import nape.constraint.WeldJoint;
import nape.constraint.Constraint;
import nape.constraint.UserConstraint;
import nape.constraint.DistanceJoint;
import nape.constraint.LineJoint;
import nape.constraint.LinearJoint;
import nape.constraint.AngleJoint;
import nape.constraint.ConstraintList;
import nape.constraint.MotorJoint;
import nape.constraint.ConstraintIterator;
import nape.phys.GravMassMode;
import nape.phys.BodyList;
import nape.constraint.PulleyJoint;
import nape.phys.InertiaMode;
import nape.phys.Interactor;
import nape.phys.InteractorList;
import nape.phys.MassMode;
import nape.phys.Material;
import nape.phys.InteractorIterator;
import nape.phys.FluidProperties;
import nape.phys.BodyIterator;
import nape.phys.Compound;
import nape.phys.CompoundList;
import nape.phys.BodyType;
import nape.phys.CompoundIterator;
import nape.callbacks.InteractionListener;
import nape.callbacks.OptionType;
import nape.phys.Body;
import nape.callbacks.PreListener;
import nape.callbacks.ListenerIterator;
import nape.callbacks.BodyListener;
import nape.callbacks.ListenerType;
import nape.callbacks.PreFlag;
import nape.callbacks.CbEvent;
import nape.callbacks.InteractionType;
import nape.callbacks.CbType;
import nape.callbacks.PreCallback;
import nape.callbacks.InteractionCallback;
import nape.callbacks.ListenerList;
import nape.callbacks.BodyCallback;
import nape.callbacks.CbTypeList;
import nape.callbacks.ConstraintListener;
import nape.callbacks.CbTypeIterator;
import nape.callbacks.Callback;
import nape.callbacks.ConstraintCallback;
import nape.callbacks.Listener;
import nape.geom.GeomPoly;
import nape.geom.Mat23;
import nape.geom.ConvexResultIterator;
import nape.geom.Ray;
import nape.geom.GeomPolyIterator;
import nape.geom.Vec2Iterator;
import nape.geom.RayResult;
import nape.geom.Winding;
import nape.geom.Vec2List;
import nape.geom.RayResultIterator;
import nape.geom.Vec2;
import nape.geom.AABB;
import nape.geom.IsoFunction;
import nape.geom.GeomVertexIterator;
import nape.geom.ConvexResult;
import nape.geom.GeomPolyList;
import nape.geom.RayResultList;
import nape.geom.Vec3;
import nape.geom.MatMN;
import nape.geom.ConvexResultList;
import nape.geom.MarchingSquares;
import nape.shape.Circle;
import nape.shape.ValidationResult;
import nape.geom.Geom;
import nape.shape.ShapeIterator;
import nape.shape.Polygon;
import nape.shape.Shape;
import nape.shape.EdgeList;
import nape.shape.EdgeIterator;
import nape.shape.ShapeList;
import nape.shape.ShapeType;
import nape.space.Broadphase;
import nape.shape.Edge;
import nape.dynamics.Contact;
import nape.dynamics.InteractionGroupList;
import nape.space.Space;
import nape.dynamics.Arbiter;
import nape.dynamics.ContactIterator;
import nape.dynamics.InteractionGroup;
import nape.dynamics.ArbiterList;
import nape.dynamics.InteractionFilter;
import nape.dynamics.ArbiterIterator;
import nape.dynamics.InteractionGroupIterator;
import nape.dynamics.FluidArbiter;
import nape.dynamics.CollisionArbiter;
import nape.dynamics.ContactList;
import nape.dynamics.ArbiterType;
import nape.util.BitmapDebug;
import nape.util.Debug;
import nape.util.ShapeDebug;
#if nape_swc@:keep #end
class ZPP_Constraint{
    public var outer:Constraint=null;
    public function clear(){}
    public var id:Int=0;
    public var userData:Dynamic<Dynamic>=null;
    public var compound:ZPP_Compound=null;
    public var space:ZPP_Space=null;
    public var active:Bool=false;
    public var stiff:Bool=false;
    public var frequency:Float=0.0;
    public var damping:Float=0.0;
    public var maxForce:Float=0.0;
    public var maxError:Float=0.0;
    public var breakUnderForce:Bool=false;
    public var breakUnderError:Bool=false;
    public var removeOnBreak:Bool=false;
    public var component:ZPP_Component=null;
    public var ignore:Bool=false;
    public var __velocity:Bool=false;
    public function new(){
        __velocity=false;
        id=ZPP_ID.Constraint();
        stiff=true;
        active=true;
        ignore=false;
        frequency=10;
        damping=1;
        maxForce=ZPP_Const.POSINF();
        maxError=ZPP_Const.POSINF();
        breakUnderForce=false;
        removeOnBreak=true;
        pre_dt=-1.0;
        cbTypes=new ZNPList_ZPP_CbType();
    }
    public function immutable_midstep(name:String){
        #if(!NAPE_RELEASE_BUILD)
        if(space!=null&&space.midstep)throw "Error: Constraint::"+name+" cannot be set during space step()";
        #end
    }
    public var cbTypes:ZNPList_ZPP_CbType=null;
    public var cbSet:ZPP_CbSet=null;
    public var wrap_cbTypes:CbTypeList=null;
    public function setupcbTypes(){
        wrap_cbTypes=ZPP_CbTypeList.get(cbTypes);
        wrap_cbTypes.zpp_inner.adder=wrap_cbTypes_adder;
        wrap_cbTypes.zpp_inner.subber=wrap_cbTypes_subber;
        wrap_cbTypes.zpp_inner.dontremove=true;
        #if(!NAPE_RELEASE_BUILD)
        wrap_cbTypes.zpp_inner._modifiable=immutable_cbTypes;
        #end
    }
    #if(!NAPE_RELEASE_BUILD)
    function immutable_cbTypes(){
        immutable_midstep("Constraint::cbTypes");
    }
    #end
    function wrap_cbTypes_subber(pcb:CbType):Void{
        var cb=pcb.zpp_inner;
        if(cbTypes.has(cb)){
            if(space!=null){
                dealloc_cbSet();
                cb.remConstraint(this);
            }
            cbTypes.remove(cb);
            if(space!=null){
                alloc_cbSet();
                wake();
            }
        }
    }
    function wrap_cbTypes_adder(cb:CbType):Bool{
        insert_cbtype(cb.zpp_inner);
        return false;
    }
    public function insert_cbtype(cb:ZPP_CbType){
        if(!cbTypes.has(cb)){
            if(space!=null){
                dealloc_cbSet();
                cb.addConstraint(this);
            }
            {
                var pre=null;
                {
                    var cx_ite=cbTypes.begin();
                    while(cx_ite!=null){
                        var j=cx_ite.elem();
                        {
                            if(ZPP_CbType.setlt(cb,j))break;
                            pre=cx_ite;
                        };
                        cx_ite=cx_ite.next;
                    }
                };
                cbTypes.inlined_insert(pre,cb);
            };
            if(space!=null){
                alloc_cbSet();
                wake();
            }
        }
    }
    public function alloc_cbSet(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                space!=null;
            };
            if(!res)throw "assert("+"space!=null"+") :: "+("space null in alloc_cbSet");
            #end
        };
        if((cbSet=space.cbsets.get(cbTypes))!=null){
            cbSet.increment();
            cbSet.addConstraint(this);
        }
    }
    public function dealloc_cbSet(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                space!=null;
            };
            if(!res)throw "assert("+"space!=null"+") :: "+("space null in dealloc_cbSet");
            #end
        };
        if(cbSet!=null){
            cbSet.remConstraint(this);
            if(cbSet.decrement()){
                space.cbsets.remove(cbSet);
                {
                    var o=cbSet;
                    {
                        #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                        var res={
                            o!=null;
                        };
                        if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_CbSet"+", in obj: "+"cbSet"+")");
                        #end
                    };
                    o.free();
                    o.next=ZPP_CbSet.zpp_pool;
                    ZPP_CbSet.zpp_pool=o;
                    #if NAPE_POOL_STATS ZPP_CbSet.POOL_CNT++;
                    ZPP_CbSet.POOL_SUB++;
                    #end
                };
            }
            cbSet=null;
        }
    }
    public function activate(){
        if(space!=null)activeInSpace();
    }
    public function deactivate(){
        if(space!=null)inactiveOrOutSpace();
    }
    public function addedToSpace(){
        if(active)activeInSpace();
        activeBodies();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.addConstraint(this);
                cx_ite=cx_ite.next;
            }
        };
    }
    public function removedFromSpace(){
        if(active)inactiveOrOutSpace();
        inactiveBodies();
        {
            var cx_ite=cbTypes.begin();
            while(cx_ite!=null){
                var cb=cx_ite.elem();
                cb.remConstraint(this);
                cx_ite=cx_ite.next;
            }
        };
    }
    public function activeInSpace(){
        alloc_cbSet();
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                component==null;
            };
            if(!res)throw "assert("+"component==null"+") :: "+("already has a component?");
            #end
        };
        {
            if(ZPP_Component.zpp_pool==null){
                component=new ZPP_Component();
                #if NAPE_POOL_STATS ZPP_Component.POOL_TOT++;
                ZPP_Component.POOL_ADDNEW++;
                #end
            }
            else{
                component=ZPP_Component.zpp_pool;
                ZPP_Component.zpp_pool=component.next;
                component.next=null;
                #if NAPE_POOL_STATS ZPP_Component.POOL_CNT--;
                ZPP_Component.POOL_ADD++;
                #end
            }
            component.alloc();
        };
        component.isBody=false;
        component.constraint=this;
    }
    public function inactiveOrOutSpace(){
        dealloc_cbSet();
        {
            var o=component;
            {
                #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
                var res={
                    o!=null;
                };
                if(!res)throw "assert("+"o!=null"+") :: "+("Free(in T: "+"ZPP_Component"+", in obj: "+"component"+")");
                #end
            };
            o.free();
            o.next=ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool=o;
            #if NAPE_POOL_STATS ZPP_Component.POOL_CNT++;
            ZPP_Component.POOL_SUB++;
            #end
        };
        component=null;
    }
    #if nape_swc@:keep #end
    public function activeBodies(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("activeBodies not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function inactiveBodies(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("inactiveBodies not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function clearcache(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("clearcache not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function validate(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("validate not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function wake_connected(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("wake_connected not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function forest(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("forest not overriden");
            #end
        };
    }
    #if nape_swc@:keep #end
    public function pair_exists(id:Int,di:Int){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("pair_exists not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function broken(){}
    #if nape_swc@:keep #end
    public function warmStart(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("warmStart not overriden");
            #end
        };
    }
    public var pre_dt:Float=0.0;
    #if nape_swc@:keep #end
    public function preStep(dt:Float):Bool{
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("preStep not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function applyImpulseVel(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("applyImpulseVel not overriden");
            #end
        };
        return false;
    }
    #if nape_swc@:keep #end
    public function applyImpulsePos(){
        {
            #if(NAPE_ASSERT&&!NAPE_RELEASE_BUILD)
            var res={
                false;
            };
            if(!res)throw "assert("+"false"+") :: "+("applyImpulsePos not overriden");
            #end
        };
        return false;
    }
    public function wake(){
        if(space!=null)space.wake_constraint(this);
    }
    public function draw(g:Debug){}
    public function copy(dict:Array<ZPP_CopyHelper>=null,todo:Array<ZPP_CopyHelper>=null):Constraint{
        return null;
    }
    public function copyto(ret:Constraint){
        var me=outer;
        for(cb in me.cbTypes)ret.cbTypes.add(cb);
        ret.removeOnBreak=me.removeOnBreak;
        ret.breakUnderError=me.breakUnderError;
        ret.breakUnderForce=me.breakUnderForce;
        ret.maxError=me.maxError;
        ret.maxForce=me.maxForce;
        ret.damping=me.damping;
        ret.frequency=me.frequency;
        ret.stiff=me.stiff;
        ret.ignore=me.ignore;
        ret.active=me.active;
    }
}
#if nape_swc@:keep #end
class ZPP_CopyHelper{
    public var id:Int=0;
    public var bc:Body=null;
    public var cb:Body->Void=null;
    function new(){}
    public static function dict(id:Int,bc:Body){
        var ret=new ZPP_CopyHelper();
        ret.id=id;
        ret.bc=bc;
        return ret;
    }
    public static function todo(id:Int,cb:Body->Void){
        var ret=new ZPP_CopyHelper();
        ret.id=id;
        ret.cb=cb;
        return ret;
    }
}
