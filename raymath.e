include std/ffi.e
include std/machine.e

include raylib.e

public constant xClamp = define_c_func(ray,"+Clamp",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Clamp(atom val,atom min,atom max)
	return c_func(xClamp,{val,min,max})
end function

public constant xLerp = define_c_func(ray,"+Lerp",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Lerp(atom start,atom xend,atom amount)
	return c_func(xLerp,{start,xend,amount})
end function

public constant xNormalize = define_c_func(ray,"+Normalize",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Normalize(atom val,atom start,atom xend)
	return c_func(xNormalize,{val,start,xend})
end function

public constant xRemap = define_c_func(ray,"+Remap",{C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Remap(atom val,atom inputStart,atom inputEnd,atom outputStart,atom outputEnd)
	return c_func(xRemap,{val,inputStart,inputEnd,outputStart,outputEnd})
end function

public constant xWrap = define_c_func(ray,"+Wrap",{C_FLOAT,C_FLOAT,C_FLOAT},C_FLOAT)

public function Wrap(atom val,atom min,atom max)
	return c_func(xWrap,{val,min,max})
end function

public constant xFloatEquals = define_c_func(ray,"+FloatEquals",{C_FLOAT,C_FLOAT},C_INT)

public function FloatEquals(atom x,atom y)
	return c_func(xFloatEquals,{x,y})
end function

public constant xVector2Zero = define_c_func(ray,"+Vector2Zero",{},VECTOR2)

public function Vector2Zero()
	return c_func(xVector2Zero,{})
end function

public constant xVector2One = define_c_func(ray,"+Vector2One",{},VECTOR2)

public function Vector2One()
	return c_func(xVector2One,{})
end function

public constant xVector2Add = define_c_func(ray,"+Vector2Add",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Add(sequence v,sequence v2)
	return c_func(xVector2Add,{v,v2})
end function

public constant xVector2AddValue = define_c_func(ray,"+Vector2AddValue",{VECTOR2,C_FLOAT},VECTOR2)

public function Vector2AddValue(sequence v,atom add)
	return c_func(xVector2AddValue,{v,add})
end function

public constant xVector2Subtract = define_c_func(ray,"+Vector2Subtract",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Subtract(sequence v,sequence v2)
	return c_func(xVector2Subtract,{v,v2})
end function

public constant xVector2SubtractValue = define_c_func(ray,"+Vector2SubtractValue",{VECTOR2,C_FLOAT},VECTOR2)

public function Vector2SubtractValue(sequence v,atom sub)
	return c_func(xVector2SubtractValue,{v,sub})
end function

public constant xVector2Length = define_c_func(ray,"+Vector2Length",{VECTOR2},C_FLOAT)

public function Vector2Length(sequence v)
	return c_func(xVector2Length,{v})
end function

public constant xVector2LengthSqr = define_c_func(ray,"+Vector2LengthSqr",{VECTOR2},C_FLOAT)

public function Vector2LengthSqr(sequence v)
	return c_func(xVector2LengthSqr,{v})
end function

public constant xVector2DotProduct = define_c_func(ray,"+Vector2DotProduct",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2DotProduct(sequence v,sequence v2)
	return c_func(xVector2DotProduct,{v,v2})
end function

public constant xVector2CrossProduct = define_c_func(ray,"+Vector2CrossProduct",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2CrossProduct(sequence v,sequence v2)
	return c_func(xVector2CrossProduct,{v,v2})
end function

public constant xVector2Distance = define_c_func(ray,"+Vector2Distance",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2Distance(sequence v,sequence v2)
	return c_func(xVector2Distance,{v,v2})
end function

public constant xVector2DistanceSqr = define_c_func(ray,"+Vector2DistanceSqr",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2DistanceSqr(sequence v,sequence v2)
	return c_func(xVector2DistanceSqr,{v,v2})
end function

public constant xVector2Angle = define_c_func(ray,"+Vector2Angle",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2Angle(sequence v,sequence v2)
	return c_func(xVector2Angle,{v,v2})
end function

public constant xVector2LineAngle = define_c_func(ray,"+Vector2LineAngle",{VECTOR2,VECTOR2},C_FLOAT)

public function Vector2LineAngle(sequence start,sequence xend)
	return c_func(xVector2LineAngle,{start,xend})
end function

public constant xVector2Scale = define_c_func(ray,"+Vector2Scale",{VECTOR2,C_FLOAT},VECTOR2)

public function Vector2Scale(sequence v,atom scale)
	return c_func(xVector2Scale,{v,scale})
end function

public constant xVector2Multiply = define_c_func(ray,"+Vector2Multiply",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Multiply(sequence v,sequence v2)
	return c_func(xVector2Multiply,{v,v2})
end function

public constant xVector2Negate = define_c_func(ray,"+Vector2Negate",{VECTOR2},VECTOR2)

public function Vector2Negate(sequence v)
	return c_func(xVector2Negate,{v})
end function

public constant xVector2Divide = define_c_func(ray,"+Vector2Divide",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Divide(sequence v,sequence v2)
	return c_func(xVector2Divide,{v,v2})
end function

public constant xVector2Normalize = define_c_func(ray,"+Vector2Normalize",{VECTOR2},VECTOR2)

public function Vector2Normalize(sequence v)
	return c_func(xVector2Normalize,{v})
end function

public constant xVector2Transform = define_c_func(ray,"+Vector2Transform",{VECTOR2,MATRIX},VECTOR2)

public function Vector2Transform(sequence v,sequence mat)
	return c_func(xVector2Transform,{v,mat})
end function

public constant xVector2Lerp = define_c_func(ray,"+Vector2Lerp",{VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function Vector2Lerp(sequence v,sequence v2,atom amount)
	return c_func(xVector2Lerp,{v,v2,amount})
end function

public constant xVector2Reflect = define_c_func(ray,"+Vector2Reflect",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Reflect(sequence v,sequence normal)
	return c_func(xVector2Reflect,{v,normal})
end function

public constant xVector2Min = define_c_func(ray,"+Vector2Min",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Min(sequence v,sequence v2)
	return c_func(xVector2Min,{v,v2})
end function

public constant xVector2Max = define_c_func(ray,"+Vector2Max",{VECTOR2,VECTOR2},VECTOR2)

public function Vector2Max(sequence v,sequence v2)
	return c_func(xVector2Max,{v,v2})
end function

public constant xVector2Rotate = define_c_func(ray,"+Vector2Rotate",{VECTOR2,C_FLOAT},VECTOR2)

public function Vector2Rotate(sequence v,atom angle)
	return c_func(xVector2Rotate,{v,angle})
end function

public constant xVector2MoveTowards = define_c_func(ray,"+Vector2MoveTowards",{VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function Vector2MoveTowards(sequence v,sequence target,atom maxDistance)
	return c_func(xVector2MoveTowards,{v,target,maxDistance})
end function

public constant xVector2Invert = define_c_func(ray,"+Vector2Invert",{VECTOR2},VECTOR2)

public function Vector2Invert(sequence v)
	return c_func(xVector2Invert,{v})
end function

public constant xVector2Clamp = define_c_func(ray,"+Vector2Clamp",{VECTOR2,VECTOR2,VECTOR2},VECTOR2)

public function Vector2Clamp(sequence v,sequence min,sequence max)
	return c_func(xVector2Clamp,{v,min,max})
end function

public constant xVector2ClampValue = define_c_func(ray,"+Vector2ClampValue",{VECTOR2,C_FLOAT,C_FLOAT},VECTOR2)

public function Vector2ClampValue(sequence v,atom min,atom max)
	return c_func(xVector2ClampValue,{v,min,max})
end function

public constant xVector2Equals = define_c_func(ray,"+Vector2Equals",{VECTOR2,VECTOR2},C_INT)

public function Vector2Equals(sequence p,sequence q)
	return c_func(xVector2Equals,{p,q})
end function

public constant xVector2Refract = define_c_func(ray,"+Vector2Refract",{VECTOR2,VECTOR2,C_FLOAT},VECTOR2)

public function Vector2Refract(sequence v,sequence n,atom r)
	return c_func(xVector2Refract,{v,n,r})
end function

public constant xVector3Zero = define_c_func(ray,"+Vector3Zero",{},VECTOR3)

public function Vector3Zero()
	return c_func(xVector3Zero,{})
end function

public constant xVector3One = define_c_func(ray,"+Vector3One",{},VECTOR3)

public function Vector3One()
	return c_func(xVector3One,{})
end function

public constant xVector3Add = define_c_func(ray,"+Vector3Add",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Add(sequence v,sequence v2)
	return c_func(xVector3Add,{v,v2})
end function

public constant xVector3AddValue = define_c_func(ray,"+Vector3AddValue",{VECTOR3,C_FLOAT},VECTOR3)

public function Vector3AddValue(sequence v,atom add)
	return c_func(xVector3AddValue,{v,add})
end function

public constant xVector3Subtract = define_c_func(ray,"+Vector3Subtract",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Subtract(sequence v,sequence v2)
	return c_func(xVector3Subtract,{v,v2})
end function

public constant xVector3SubtractValue = define_c_func(ray,"+Vector3SubtractValue",{VECTOR3,C_FLOAT},VECTOR3)

public function Vector3SubtractValue(sequence v,atom sub)
	return c_func(xVector3SubtractValue,{v,sub})
end function

public constant xVector3Scale = define_c_func(ray,"+Vector3Scale",{VECTOR3,C_FLOAT},VECTOR3)

public function Vector3Scale(sequence v,atom scalar)
	return c_func(xVector3Scale,{v,scalar})
end function

public constant xVector3Multiply = define_c_func(ray,"+Vector3Multiply",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Multiply(sequence v,sequence v2)
	return c_func(xVector3Multiply,{v,v2})
end function

public constant xVector3CrossProduct = define_c_func(ray,"+Vector3CrossProduct",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3CrossProduct(sequence v,sequence v2)
	return c_func(xVector3CrossProduct,{v,v2})
end function

public constant xVector3Perpendicular = define_c_func(ray,"+Vector3Perpendicular",{VECTOR3},VECTOR3)

public function Vector3Perpendicular(sequence v)
	return c_func(xVector3Perpendicular,{v})
end function

public constant xVector3Length = define_c_func(ray,"+Vector3Length",{VECTOR3},C_FLOAT)

public function Vector3Length(sequence v)
	return c_func(xVector3Length,{v})
end function

public constant xVector3LengthSqr = define_c_func(ray,"+Vector3LengthSqr",{VECTOR3},C_FLOAT)

public function Vector3LengthSqr(sequence v)
	return c_func(xVector3LengthSqr,{v})
end function

public constant xVector3DotProduct = define_c_func(ray,"+Vector3DotProduct",{VECTOR3,VECTOR3},C_FLOAT)

public function Vector3DotProduct(sequence v,sequence v2)
	return c_func(xVector3DotProduct,{v,v2})
end function

public constant xVector3Distance = define_c_func(ray,"+Vector3Distance",{VECTOR3,VECTOR3},C_FLOAT)

public function Vector3Distance(sequence v,sequence v2)
	return c_func(xVector3Distance,{v,v2})
end function

public constant xVector3DistanceSqr = define_c_func(ray,"+Vector3DistanceSqr",{VECTOR3,VECTOR3},C_FLOAT)

public function Vector3DistanceSqr(sequence v,sequence v2)
	return c_func(xVector3DistanceSqr,{v,v2})
end function

public constant xVector3Angle = define_c_func(ray,"+Vector3Angle",{VECTOR3,VECTOR3},C_FLOAT)

public function Vector3Angle(sequence v,sequence v2)
	return c_func(xVector3Angle,{v,v2})
end function

public constant xVector3Negate = define_c_func(ray,"+Vector3Negate",{VECTOR3},VECTOR3)

public function Vector3Negate(sequence v)
	return c_func(xVector3Negate,{v})
end function

public constant xVector3Divide = define_c_func(ray,"+Vector3Divide",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Divide(sequence v,sequence v2)
	return c_func(xVector3Divide,{v,v2})
end function

public constant xVector3Normalize = define_c_func(ray,"+Vector3Normalize",{VECTOR3},VECTOR3)

public function Vector3Normalize(sequence v)
	return c_func(xVector3Normalize,{v})
end function

public constant xVector3Project = define_c_func(ray,"+Vector3Project",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Project(sequence v,sequence v2)
	return c_func(xVector3Project,{v,v2})
end function

public constant xVector3Reject = define_c_func(ray,"+Vector3Reject",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Reject(sequence v,sequence v2)
	return c_func(xVector3Reject,{v,v2})
end function

public constant xVector3OrthoNormalize = define_c_proc(ray,"+Vector3OrthoNormalize",{C_POINTER,C_POINTER})

public procedure Vector3OrthoNormalize(atom v1,atom v2)
	c_proc(xVector3OrthoNormalize,{v1,v2})
end procedure

public constant xVector3Transform = define_c_func(ray,"+Vector3Transform",{VECTOR3,MATRIX},VECTOR3)

public function Vector3Transform(sequence v,sequence mat)
	return c_func(xVector3Transform,{v,mat})
end function

public constant xVector3RotateByQuaternion = define_c_func(ray,"+Vector3RotateByQuaternion",{VECTOR3,QUATERNION},VECTOR3)

public function Vector3RotateByQuaternion(sequence v,sequence q)
	return c_func(xVector3RotateByQuaternion,{v,q})
end function

public constant xVector3RotateByAxisAngle = define_c_func(ray,"+Vector3RotateByAxisAngle",{VECTOR3,VECTOR3,C_FLOAT},VECTOR3)

public function Vector3RotateByAxisAngle(sequence v,sequence axis,atom angle)
	return c_func(xVector3RotateByAxisAngle,{v,axis,angle})
end function

public constant xVector3MoveTowards = define_c_func(ray,"+Vector3MoveTowards",{VECTOR3,VECTOR3,C_FLOAT},VECTOR3)

public function Vector3MoveTowards(sequence v,sequence target,atom maxDistance)
	return c_func(xVector3MoveTowards,{v,target,maxDistance})
end function

public constant xVector3Lerp = define_c_func(ray,"+Vector3Lerp",{VECTOR3,VECTOR3,C_FLOAT},VECTOR3)

public function Vector3Lerp(sequence v,sequence v2,atom amount)
	return c_func(xVector3Lerp,{v,v2,amount})
end function

public constant xVector3CubicHermite = define_c_func(ray,"+Vector3CubicHermite",{VECTOR3,VECTOR3,VECTOR3,VECTOR3,C_FLOAT},VECTOR3)

public function Vector3CubicHermite(sequence v,sequence tangent,sequence v2,sequence tangent2,atom amount)
	return c_func(xVector3CubicHermite,{v,tangent,v2,tangent2,amount})
end function

public constant xVector3Reflect = define_c_func(ray,"+Vector3Reflect",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Reflect(sequence v,sequence normal)
	return c_func(xVector3Reflect,{v,normal})
end function

public constant xVector3Min = define_c_func(ray,"+Vector3Min",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Min(sequence v,sequence v2)
	return c_func(xVector3Min,{v,v2})
end function

public constant xVector3Max = define_c_func(ray,"+Vector3Max",{VECTOR3,VECTOR3},VECTOR3)

public function Vector3Max(sequence v,sequence v2)
	return c_func(xVector3Max,{v,v2})
end function

public constant xVector3Barycenter = define_c_func(ray,"+Vector3Barycenter",{VECTOR3,VECTOR3,VECTOR3,VECTOR3},VECTOR3)

public function Vector3Barycenter(sequence p,sequence a,sequence b,sequence c)
	return c_func(xVector3Barycenter,{p,a,b,c})
end function

public constant xVector3Unproject = define_c_func(ray,"+Vector3Unproject",{VECTOR3,MATRIX,MATRIX},VECTOR3)

public function Vector3Unproject(sequence source,sequence projection,sequence view)
	return c_func(xVector3Unproject,{source,projection,view})
end function

public constant xVector3ToFloatV = define_c_func(ray,"+Vector3ToFloatV",{VECTOR3},C_FLOAT)

public function Vector3ToFloatV(sequence v)
	return c_func(xVector3ToFloatV,{v})
end function

public constant xVector3Invert = define_c_func(ray,"+Vector3Invert",{VECTOR3},VECTOR3)

public function Vector3Invert(sequence v)
	return c_func(xVector3Invert,{v})
end function

public constant xVector3Clamp = define_c_func(ray,"+Vector3Clamp",{VECTOR3,VECTOR3,VECTOR3},VECTOR3)

public function Vector3Clamp(sequence v,sequence min,sequence max)
	return c_func(xVector3Clamp,{v,min,max})
end function

public constant xVector3ClampValue = define_c_func(ray,"+Vector3ClampValue",{VECTOR3,C_FLOAT,C_FLOAT},VECTOR3)

public function Vector3ClampValue(sequence v,atom min,atom max)
	return c_func(xVector3ClampValue,{v,min,max})
end function

public constant xVector3Equals = define_c_func(ray,"+Vector3Equals",{VECTOR3,VECTOR3},C_INT)

public function Vector3Equals(sequence p,sequence q)
	return c_func(xVector3Equals,{p,q})
end function

public constant xVector3Refract = define_c_func(ray,"+Vector3Refract",{VECTOR3,VECTOR3,C_FLOAT},VECTOR3)

public function Vector3Refract(sequence v,sequence n,atom r)
	return c_func(xVector3Refract,{v,n,r})
end function

public constant xVector4Zero = define_c_func(ray,"+Vector4Zero",{},VECTOR4)

public function Vector4Zero()
	return c_func(xVector4Zero,{})
end function

public constant xVector4One = define_c_func(ray,"+Vector4One",{},VECTOR4)

public function Vector4One()
	return c_func(xVector4One,{})
end function

public constant xVector4Add = define_c_func(ray,"+Vector4Add",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Add(sequence v,sequence v2)
	return c_func(xVector4Add,{v,v2})
end function

public constant xVector4AddValue = define_c_func(ray,"+Vector4AddValue",{VECTOR4,C_FLOAT},VECTOR4)

public function Vector4AddValue(sequence v,atom add)
	return c_func(xVector4AddValue,{v,add})
end function

public constant xVector4Subtract = define_c_func(ray,"+Vector4Subtract",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Subtract(sequence v,sequence v2)
	return c_func(xVector4Subtract,{v,v2})
end function

public constant xVector4SubtractValue = define_c_func(ray,"+Vector4SubtractValue",{VECTOR4,C_FLOAT},VECTOR4)

public function Vector4SubtractValue(sequence v,atom add)
	return c_func(xVector4SubtractValue,{v,add})
end function

public constant xVector4Length = define_c_func(ray,"+Vector4Length",{VECTOR4},C_FLOAT)

public function Vector4Length(sequence v)
	return c_func(xVector4Length,{v})
end function

public constant xVector4LengthSqr = define_c_func(ray,"+Vector4LengthSqr",{VECTOR4},C_FLOAT)

public function Vector4LengthSqr(sequence v)
	return c_func(xVector4LengthSqr,{v})
end function

public constant xVector4DotProduct = define_c_func(ray,"+Vector4DotProduct",{VECTOR4,VECTOR4},C_FLOAT)

public function Vector4DotProduct(sequence v,sequence v2)
	return c_func(xVector4DotProduct,{v,v2})
end function

public constant xVector4Distance = define_c_func(ray,"+Vector4Distance",{VECTOR4,VECTOR4},C_FLOAT)

public function Vector4Distance(sequence v,sequence v2)
	return c_func(xVector4Distance,{v,v2})
end function

public constant xVector4DistanceSqr = define_c_func(ray,"+Vector4DistanceSqr",{VECTOR4,VECTOR4},C_FLOAT)

public function Vector4DistanceSqr(sequence v,sequence v2)
	return c_func(xVector4DistanceSqr,{v,v2})
end function

public constant xVector4Scale = define_c_func(ray,"+Vector4Scale",{VECTOR4,C_FLOAT},VECTOR4)

public function Vector4Scale(sequence v,atom scale)
	return c_func(xVector4Scale,{v,scale})
end function

public constant xVector4Multiply = define_c_func(ray,"+Vector4Multiply",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Multiply(sequence v,sequence v2)
	return c_func(xVector4Multiply,{v,v2})
end function

public constant xVector4Negate = define_c_func(ray,"+Vector4Negate",{VECTOR4},VECTOR4)

public function Vector4Negate(sequence v)
	return c_func(xVector4Negate,{v})
end function

public constant xVector4Divide = define_c_func(ray,"+Vector4Divide",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Divide(sequence v,sequence v2)
	return c_func(xVector4Divide,{v,v2})
end function

public constant xVector4Normalize = define_c_func(ray,"+Vector4Normalize",{VECTOR4},VECTOR4)

public function Vector4Normalize(sequence v)
	return c_func(xVector4Normalize,{v})
end function

public constant xVector4Min = define_c_func(ray,"+Vector4Min",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Min(sequence v,sequence v2)
	return c_func(xVector4Min,{v,v2})
end function

public constant xVector4Max = define_c_func(ray,"+Vector4Max",{VECTOR4,VECTOR4},VECTOR4)

public function Vector4Max(sequence v,sequence v2)
	return c_func(xVector4Max,{v,v2})
end function

public constant xVector4Lerp = define_c_func(ray,"+Vector4Lerp",{VECTOR4,VECTOR4,C_FLOAT},VECTOR4)

public function Vector4Lerp(sequence v,sequence v2,atom amount)
	return c_func(xVector4Lerp,{v,v2,amount})
end function

public constant xVector4MoveTowards = define_c_func(ray,"+Vector4MoveTowards",{VECTOR4,VECTOR4,C_FLOAT},VECTOR4)

public function Vector4MoveTowards(sequence v,sequence target,atom maxDistance)
	return c_func(xVector4MoveTowards,{v,target,maxDistance})
end function

public constant xVector4Invert = define_c_func(ray,"+Vector4Invert",{VECTOR4},VECTOR4)

public function Vector4Invert(sequence v)
	return c_func(xVector4Invert,{v})
end function

public constant xVector4Equals = define_c_func(ray,"+Vector4Equals",{VECTOR4,VECTOR4},C_INT)

public function Vector4Equals(sequence p,sequence q)
	return c_func(xVector4Equals,{p,q})
end function

public constant xMatrixDeterminant = define_c_func(ray,"+MatrixDeterminant",{MATRIX},C_FLOAT)

public function MatrixDeterminant(sequence mat)
	return c_func(xMatrixDeterminant,{mat})
end function

public constant xMatrixTrace = define_c_func(ray,"+MatrixTrace",{MATRIX},C_FLOAT)

public function MatrixTrace(sequence mat)
	return c_func(xMatrixTrace,{mat})
end function

public constant xMatrixTranspose = define_c_func(ray,"+MatrixTranspose",{MATRIX},MATRIX)

public function MatrixTranspose(sequence mat)
	return c_func(xMatrixTranspose,{mat})
end function

public constant xMatrixInvert = define_c_func(ray,"+MatrixInvert",{MATRIX},MATRIX)

public function MatrixInvert(sequence mat)
	return c_func(xMatrixInvert,{mat})
end function

public constant xMatrixIdentity = define_c_func(ray,"+MatrixIdentity",{},MATRIX)

public function MatrixIdentity()
	return c_func(xMatrixIdentity,{})
end function

public constant xMatrixAdd = define_c_func(ray,"+MatrixAdd",{MATRIX,MATRIX},MATRIX)

public function MatrixAdd(sequence left,sequence right)
	return c_func(xMatrixAdd,{left,right})
end function

public constant xMatrixSubtract = define_c_func(ray,"+MatrixSubtract",{MATRIX,MATRIX},MATRIX)

public function MatrixSubtract(sequence left,sequence right)
	return c_func(xMatrixSubtract,{left,right})
end function

public constant xMatrixMultiply = define_c_func(ray,"+MatrixMultiply",{MATRIX,MATRIX},MATRIX)

public function MatrixMultiply(sequence left,sequence right)
	return c_func(xMatrixMultiply,{left,right})
end function

public constant xMatrixMultiplyValue = define_c_func(ray,"+MatrixMultiplyValue",{MATRIX,C_FLOAT},MATRIX)

public function MatrixMultiplyValue(sequence left,atom val)
	return c_func(xMatrixMultiplyValue,{left,val})
end function

public constant xMatrixTranslate = define_c_func(ray,"+MatrixTranslate",{C_FLOAT,C_FLOAT,C_FLOAT},MATRIX)

public function MatrixTranslate(atom x,atom y,atom z)
	return c_func(xMatrixTranslate,{x,y,z})
end function

public constant xMatrixRotate = define_c_func(ray,"+MatrixRotate",{VECTOR3,C_FLOAT},MATRIX)

public function MatrixRotate(sequence axis,atom angle)
	return c_func(xMatrixRotate,{axis,angle})
end function

public constant xMatrixRotateX = define_c_func(ray,"+MatrixRotateX",{C_FLOAT},MATRIX)

public function MatrixRotateX(atom angle)
	return c_func(xMatrixRotateX,{angle})
end function

public constant xMatrixRotateY = define_c_func(ray,"+MatrixRotateY",{C_FLOAT},MATRIX)

public function MatrixRotateY(atom angle)
	return c_func(xMatrixRotateY,{angle})
end function

public constant xMatrixRotateZ = define_c_func(ray,"+MatrixRotateZ",{C_FLOAT},MATRIX)

public function MatrixRotateZ(atom angle)
	return c_func(xMatrixRotateZ,{angle})
end function

public constant xMatrixRotateXYZ = define_c_func(ray,"+MatrixRotateXYZ",{VECTOR3},MATRIX)

public function MatrixRotateXYZ(sequence angle)
	return c_func(xMatrixRotateXYZ,{angle})
end function

public constant xMatrixRotateZYX = define_c_func(ray,"+MatrixRotateZYX",{VECTOR3},MATRIX)

public function MatrixRotateZYX(sequence angle)
	return c_func(xMatrixRotateZYX,{angle})
end function

public constant xMatrixScale = define_c_func(ray,"+MatrixScale",{C_FLOAT,C_FLOAT,C_FLOAT},MATRIX)

public function MatrixScale(atom x,atom y,atom z)
	return c_func(xMatrixScale,{x,y,z})
end function

public constant xMatrixFrustum = define_c_func(ray,"+MatrixFrustum",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},MATRIX)

public function MatrixFrustum(atom left,atom right,atom bottom,atom top,atom nearPlane,atom farPlane)
	return c_func(xMatrixFrustum,{left,right,bottom,top,nearPlane,farPlane})	
end function

public constant xMatrixPerspective = define_c_func(ray,"+MatrixPerspective",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},MATRIX)

public function MatrixPerspective(atom fovY,atom aspect,atom nearPlane,atom farPlane)
	return c_func(xMatrixPerspective,{fovY,aspect,nearPlane,farPlane})
end function

public constant xMatrixOrtho = define_c_func(ray,"+MatrixOrtho",{C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE,C_DOUBLE},MATRIX)

public function MatrixOrtho(atom left,atom right,atom bottom,atom top,atom nearPlane,atom farPlane)
	return c_func(xMatrixOrtho,{left,right,bottom,top,nearPlane,farPlane})
end function

public constant xMatrixLookAt = define_c_func(ray,"+MatrixLookAt",{VECTOR3,VECTOR3,VECTOR3},MATRIX)

public function MatrixLookAt(sequence eye,sequence target,sequence up)
	return c_func(xMatrixLookAt,{eye,target,up})
end function

public constant xMatrixToFloatV = define_c_func(ray,"+MatrixToFloatV",{MATRIX},C_FLOAT)

public function MatrixToFloatV(sequence mat)
	return c_func(xMatrixToFloatV,{mat})
end function

public constant xQuaternionAdd = define_c_func(ray,"+QuaternionAdd",{QUATERNION,QUATERNION},QUATERNION)

public function QuaternionAdd(sequence q,sequence q2)
	return c_func(xQuaternionAdd,{q,q2})
end function

public constant xQuaternionAddValue = define_c_func(ray,"+QuaternionAddValue",{QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionAddValue(sequence q,atom add)
	return c_func(xQuaternionAddValue,{q,add})
end function

public constant xQuaternionSubtract = define_c_func(ray,"+QuaternionSubtract",{QUATERNION,QUATERNION},QUATERNION)

public function QuaternionSubtract(sequence q,sequence q2)
	return c_func(xQuaternionSubtract,{q,q2})
end function

public constant xQuaternionSubtractValue = define_c_func(ray,"+QuaternionSubtractValue",{QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionSubtractValue(sequence q,atom sub)
	return c_func(xQuaternionSubtractValue,{q,sub})
end function

public constant xQuaternionIdentity = define_c_func(ray,"+QuaternionIdentity",{},QUATERNION)

public function QuaternionIdentity()
	return c_func(xQuaternionIdentity,{})
end function

public constant xQuaternionLength = define_c_func(ray,"+QuaternionLength",{QUATERNION},C_FLOAT)

public function QuaternionLength(sequence q)
	return c_func(xQuaternionLength,{q})
end function

public constant xQuaternionNormalize = define_c_func(ray,"+QuaternionNormalize",{QUATERNION},QUATERNION)

public function QuaternionNormalize(sequence q)
	return c_func(xQuaternionNormalize,{q})
end function

public constant xQuaternionInvert = define_c_func(ray,"+QuaternionInvert",{QUATERNION},QUATERNION)

public function QuaternionInvert(sequence q)
	return c_func(xQuaternionInvert,{q})
end function

public constant xQuaternionMultiply = define_c_func(ray,"+QuaternionMultiply",{QUATERNION,QUATERNION},QUATERNION)

public function QuaternionMultiply(sequence q,sequence q2)
	return c_func(xQuaternionMultiply,{q,q2})
end function

public constant xQuaternionScale = define_c_func(ray,"+QuaternionScale",{QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionScale(sequence q,atom mul)
	return c_func(xQuaternionScale,{q,mul})
end function

public constant xQuaternionDivide = define_c_func(ray,"+QuaternionDivide",{QUATERNION,QUATERNION},QUATERNION)

public function QuaternionDivide(sequence q,sequence q2)
	return c_func(xQuaternionDivide,{q,q2})
end function

public constant xQuaternionLerp = define_c_func(ray,"+QuaternionLerp",{QUATERNION,QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionLerp(sequence q,sequence q2,atom amount)
	return c_func(xQuaternionLerp,{q,q2,amount})
end function

public constant xQuaternionNlerp = define_c_func(ray,"+QuaternionNlerp",{QUATERNION,QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionNlerp(sequence q,sequence q2,atom amount)
	return c_func(xQuaternionNlerp,{q,q2,amount})
end function

public constant xQuaternionSlerp = define_c_func(ray,"+QuaternionSlerp",{QUATERNION,QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionSlerp(sequence q,sequence q2,atom amount)
	return c_func(xQuaternionSlerp,{q,q2,amount})
end function

public constant xQuaternionCubicHermiteSpline = define_c_func(ray,"+QuaternionCubicHermiteSpline",{QUATERNION,QUATERNION,QUATERNION,QUATERNION,C_FLOAT},QUATERNION)

public function QuaternionCubicHermiteSpline(sequence q,sequence outTangent,sequence q2,sequence inTangent2,atom t)
	return c_func(xQuaternionCubicHermiteSpline,{q,outTangent,q2,inTangent2,t})
end function

public constant xQuaternionFromVector3ToVector3 = define_c_func(ray,"+QuaternionFromVector3ToVector3",{VECTOR3,VECTOR3},QUATERNION)

public function QuaternionFromVector3ToVector3(sequence xfrom,sequence xto)
	return c_func(xQuaternionFromVector3ToVector3,{xfrom,xto})
end function

public constant xQuaternionFromMatrix = define_c_func(ray,"+QuaternionFromMatrix",{MATRIX},QUATERNION)

public function QuaternionFromMatrix(sequence mat)
	return c_func(xQuaternionFromMatrix,{mat})
end function

public constant xQuaternionToMatrix = define_c_func(ray,"+QuaternionToMatrix",{QUATERNION},MATRIX)

public function QuaternionToMatrix(sequence q)
	return c_func(xQuaternionToMatrix,{q})
end function

public constant xQuaternionFromAxisAngle = define_c_func(ray,"+QuaternionFromAxisAngle",{VECTOR3,C_FLOAT},QUATERNION)

public function QuaternionFromAxisAngle(sequence axis,atom angle)
	return c_func(xQuaternionFromAxisAngle,{axis,angle})
end function

public constant xQuaternionToAxisAngle = define_c_proc(ray,"+QuaternionToAxisAngle",{QUATERNION,C_POINTER,C_POINTER})

public procedure QuaternionToAxisAngle(sequence q,atom outAxis,atom outAngle)
	c_proc(xQuaternionToAxisAngle,{q,outAxis,outAngle})
end procedure

public constant xQuaternionFromEuler = define_c_func(ray,"+QuaternionFromEuler",{C_FLOAT,C_FLOAT,C_FLOAT},QUATERNION)

public function QuaternionFromEuler(atom pitch,atom yaw,atom roll)
	return c_func(xQuaternionFromEuler,{pitch,yaw,roll})
end function

public constant xQuaternionToEuler = define_c_func(ray,"+QuaternionToEuler",{QUATERNION},VECTOR3)

public function QuaternionToEuler(sequence q)
	return c_func(xQuaternionToEuler,{q})
end function

public constant xQuaternionTransform = define_c_func(ray,"+QuaternionTransform",{QUATERNION,MATRIX},QUATERNION)

public function QuaternionTransform(sequence q,sequence mat)
	return c_func(xQuaternionTransform,{q,mat})
end function

public constant xQuaternionEquals = define_c_func(ray,"+QuaternionEquals",{QUATERNION,QUATERNION},C_INT)

public function QuaternionEquals(sequence p,sequence q)
	return c_func(xQuaternionEquals,{p,q})
end function

public constant xMatrixCompose = define_c_func(ray,"+MatrixCompose",{VECTOR3,QUATERNION,VECTOR3},MATRIX)

public function MatrixCompose(sequence translation,sequence rotation,sequence scale)
	return c_func(xMatrixCompose,{translation,rotation,scale})
end function

public constant xMatrixDecompose = define_c_proc(ray,"+MatrixDecompose",{MATRIX,C_POINTER,C_POINTER,C_POINTER})

public procedure MatrixDecompose(sequence mat,atom translation,atom rotation,atom scale)
	c_proc(xMatrixDecompose,{mat,translation,rotation,scale})
end procedure
­1.0