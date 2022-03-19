
<font face="Futura" color="#000000" size=6 > **Calculate the Point of the Slave Mechanism** </font>
=======
    

<font face="Futura" color="#000000" size=5 > ***ISSUES*** </font>

<font face="Avenir Next" size=3> 


A slave mechanism is attached on two arbitrary point at a torsional hinge `Hinge A` and spherical hinge`Hinge B` thougth `SlaveArm A` and `SlaveArm B` respectively, which means that `SlaveArm A` can only rotate at a certain angle to the `Hinge A` while there is no this limitations on `SlaveArm B`.

Therefore, the intersection node `SlavePoint` of `SlaveArm A` and `SlaveArm B` can be determined if the length ($LengthSlave_{a}$ and $LengthSlave_{b}$) and attached location ($AttachPoint^{g/l}_{a}$ and $AttachPoint^{g/l}_{b}$) of two arms and the rotation plane of `Hinge A` ($RotaVec^{g/l}_{a}$) are given, where the prime notion indicates it is a *global* or *local* coordinate.
  
</font>


<font face="Futura" color="#000000" size=5 > ***PROCESS***</font>

<font face="Avenir Next" color="#000000" size=4 > ***Equation Setting Up*** </font>

<font face="Avenir Next" size=3> 

Local system can be used to describe the motion of `SlaveArm A`. As the `SlaveArm A` is rotating in a certain plane with the normal vector $RotaVec^{l}_{a}$, the motion curve at the local system of `Hinge A` is a circle where the center is $AttachPoint^{l}_{a}$ and the radius is $LengthSlave_{a}$. According to <a href="http://blog.sina.com.cn/s/blog_6496e38e0102vi7e.html">this reference</a>, the parametrical function of this curve, which is also the local coordinate of $SlavePoint$, can be put as:

<center>
$circle(\theta)=SlavePoint^{l}(\theta)=AttachPoint^{l}_{a}+LengthSlave_{a}\cdot cos(\theta)\cdot \vec{a}+LengthSlave_{b}\cdot sin(\theta)\cdot \vec{b}$
</center>

where $\vec{a}$ and $\vec{b}$ are two vectors in the rotation plane which are normal to each others.

Meanwhile, the length constraints of `SlaveArm B` can be obtained:  

<center>
$eqn1: \Vert SlavePoint^{g}-AttachPoint^{g}_{b}\Vert-lb==0$ 
</center>
</font>

<font face="Avenir Next" color="#000000" size=4 > ***Linear Transformation*** </font>

<font face="Avenir Next" size=3> 

One more thing should be paid attention is the tansformation of global and local system. As known, here is only about the linear transforming including ratation and translation but nothing with scale. So if the local coordinate is replaced by global one, it also stands for a same shape.

For the convenience, all the $SlavePoint$ should be transformed into a consistent formation, and the circle curve function can be rewriten as a global formation:

<center>
$SlavePoint^{g}(\theta)=M_{SP}\cdot SlavePoint^{l}(\theta)+O_{L}$
</center>

where $M_{SP}$ is the rotation matrix and the $O_{L}$ is the local origin.

</font>


<font face="Avenir Next" color="#000000" size=4 > ***Equation Solving*** </font>

<font face="Avenir Next" size=3> 

Adopting the circle curve function to the `eqn1`, the result is:  

<center>
$\Vert M_{SP}\cdot AttachPoint^{l}_{a}+LengthSlave_{a}\cdot cos(\theta)\cdot M_{  SP}\cdot \vec{a}+LengthSlave_{a}\cdot sin(\theta)\cdot M_{SP}\cdot \vec{b}+O_{L}-AttachPoint^{g}_{b} \Vert-LengthSlave_b==0$ 
</center>

<!-- To expand this equation, it is:  

\begin{array}{|c|r} AP_{a,X}^{l}-AP_{b,X}^{l}+la \cdot cos(\theta) \cdot a_X+lb \cdot sin(\theta) \cdot b_X &  \\ AP_{a,Y}^{l}-AP_{b,Y}^{l}+la \cdot cos(\theta) \cdot a_Y+lb \cdot sin(\theta) \cdot b_Y & ==0 \\ AP_{a,Z}^{l}-AP_{b,Z}^{l}+la \cdot cos(\theta) \cdot a_Z+lb \cdot sin(\theta) \cdot b_Z &  \end{array} -->

To be more simplifier, it can be rewriten as  

$A+B\cdot cos^2(\theta)+C\cdot sin^2(\theta)+D\cdot cos(\theta)+E\cdot sin(\theta)+F\cdot cos(\theta)\cdot sin(\theta)==0$

where: 

$A=\Vert M_{SP}\cdot AttachPoint^{l}_{a}+O_{L}-AttachPoint^{g}_{b}\Vert^2-LengthSlave_b^2$  

$B=LengthSlave_a^2\cdot \Vert M_{SP}\cdot \vec{a} \Vert^2$  

$C=LengthSlave_a^2\cdot \Vert M_{SP}\cdot \vec{b} \Vert^2$  

$D=2\cdot LengthSlave_a\cdot (M_{SP}\cdot AttachPoint^{l}_{a}+O_{L}-AttachPoint^{g}_{b})'\cdot M_{SP}\cdot \vec{a}$  

$E=2\cdot LengthSlave_a\cdot (M_{SP}\cdot AttachPoint^{l}_{a}+O_{L}-AttachPoint^{g}_{b})'\cdot M_{SP}\cdot \vec{b}$

$F=2\cdot LengthSlave_a\cdot LengthSlave_a\cdot M_{SP}\cdot \vec{a}\cdot M_{SP}\cdot \vec{b}$

With the help of `MATLAB`, the result of this equation is $\theta=2*arctan(\alpha)$ where $\alpha$ should meet these conditions:  

<center>
$eqn.2: A+B+D+2 E\cdot \alpha+2F\cdot \alpha+2A\cdot \alpha^2 + A\cdot \alpha^4 + B\cdot \alpha^4 + 4 C\cdot \alpha^2 + 2 E\cdot \alpha^3 == D\cdot \alpha^4 + 2 F\cdot \alpha^3 + 2 B\cdot \alpha^2$
</center>

Transfroming to a standard formation, $eqn.2$ can be put as:

<center>
$eqn.2.1: M\cdot \alpha^4+N\cdot \alpha^3+P\cdot \alpha^2+Q\cdot \alpha^1+T==0$
</center>


where:

$M=A+B-D$

$N=2E-2F$

$P=2A+4C-2B$

$Q=2E+2F$

$T=A+B+D$

</font>


<font face="Avenir Next" color="#000000" size=4 > ***Solution for Univariate Quartic Equation*** </font>

<font face="Avenir Next" size=3> 

There is a standard methed to deal with the `univariate quartic equation` such as $eqn2.1$ and here are several situations:

- if **M=0**, eqn2.1 can be rewriten as a `univariate cubic equation` formation, but:
	+ if **N=0**, it continues to be a `univariate quadratic equation` formation, but: 
		* if **P=0**, it turns to be a `linear equation`, but:
			- if **Q=0**, but: 
				+ if **T≠0**, there is **no solution**
				+ if **T=0**, there are **too many solution**
			- if **Q≠0**, there is a unique solution, $\alpha=-Q/T$
		* if **P≠0**, the solution for `univariate quadratic equation` depends on the value of parameters:
			- if $Q^2-4\cdot P\cdot T<0$, there is **no solution**
			- if $Q^2-4\cdot P\cdot T\geqq 0$, $\alpha=\frac{-Q\pm \sqrt{Q^2-4\cdot P\cdot T}}{2\cdot P}$
	+ if **N≠0**, according to the `ShengJin Method`, <a href="https://blog.csdn.net/u012912039/article/details/101363323">the algorithm</a> for `univariate cubic equation` is easy to get.
- if **M≠0**, according to the `TianHeng Method`, <a href="https://baike.baidu.com/item/一元四次方程求根公式/10721996">the algorithm</a> for `univariate quartic equation` is easy to get.

After solved the $eqn2.1$, the value of $\alpha$ can be put in to the equation $\theta=2*arctan(\alpha)$ and the value of $\theta$ is got.





</font>
---------
