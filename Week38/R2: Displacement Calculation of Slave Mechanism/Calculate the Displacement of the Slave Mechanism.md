
<font face="Futura" color="#000000" size=6 > **Calculate the Displacement of the Slave Mechanism** </font>
=======
    

<font face="Futura" color="#000000" size=5 > ***ISSUES*** </font>

<font face="Avenir Next" size=3> 


A slave mechanism is attached on two arbitrary point at a torsional hinge `Hinge A` and spherical hinge`Hinge B` thougth `SlaveArm A` and `SlaveArm B` respectively, which means that `SlaveArm A` can only rotate at a certain angle to the `Hinge A` while there is no this limitations on `SlaveArm B`.

Therefore, the intersection node `SlavePoint` of `SlaveArm A` and `SlaveArm B` can be determined. Bisides, the displacement $d^{SP}$ of the `SlavePoint` can be determined by the displacement $d^{A}$ of $AttachPoint^{A}$ and the displacement $d^{B}$ of $AttachPoint^{B}$ and the rotating limitation $VecRota^{A}$ of the `Hinge A`.  
  
</font>


<font face="Futura" color="#000000" size=5 > ***PROCESS***</font>

<font face="Avenir Next" color="#000000" size=4 > ***Distance Contraints*** </font>

<font face="Avenir Next" size=3> 

As known, the displacement of a point can be seen as two part: the 1st order of the displacement $d_m$ and the 2nd order of the displacement $d_c$. The dimension of $d_m$ is $[Dimension \times DoF]$ and the dimension of $d_c$ is $[DoF \times DoF \times Dimension]$. So for the Ron Resch pattern in 3-dimension system, those are $d_m^{[3\times 6]}$, $d_c^{[6\times 6 \times 3]}$.

Intuitively, that 18 unknown variables in the $d_m$ needs 18 equations for the 1st displacement and similar with the $d_c$.   

As the `SlavePoint` is the intersection at the `SlaveArm A` and `SlaveArm B`, so there are two distance constraints: 

<center>
$eqn1\rightarrow \Vert SlavePoint-AttachPoint^{A}\Vert==\Vert (SlavePoint+d^{SP})-(AttachPoint^{A}+d^{A})\Vert$

$eqn2\rightarrow \Vert SlavePoint-AttachPoint^{B}\Vert==\Vert (SlavePoint+d^{SP})-(AttachPoint^{B}+d^{B})\Vert$
</center>

According to the expression of the displacement at the 1st and the 2nd order, these 12 equations derived from the distance constraints for the 1st displacement can be concluded:

<center>
$eqn1.1\rightarrow CompatibleMatrix^{AS}\cdot \left( \begin{array}{c} d_m^A \\ d_m^S \end{array} \right)==0$  

$eqn1.2\rightarrow CompatibleMatrix^{BS}\cdot \left( \begin{array}{c} d_m^B \\ d_m^S \end{array} \right)==0$  

</center>

As for the 2nd displacement, these are:

<center>
$eqn2.1\rightarrow CompatibleMatrix^{AS}\cdot \left( \begin{array}{c} d_c^A \\ d_c^S \end{array} \right)+\frac{\left( \begin{array}{c} d_m^A \\ d_m^S \end{array} \right)^T \cdot \widetilde{H}\cdot \left( \begin{array}{c} d_m^A \\ d_m^S \end{array} \right)}{2\cdot length^{AS}}==0$  

$eqn2.2\rightarrow CompatibleMatrix^{BS}\cdot \left( \begin{array}{c} d_c^B \\ d_c^S \end{array} \right)+\frac{\left( \begin{array}{c} d_m^B \\ d_m^S \end{array} \right)^T \cdot \widetilde{H}\cdot \left( \begin{array}{c} d_m^B \\ d_m^S \end{array} \right)}{2\cdot length^{BS}}==0$ 

</center>

where $CompatibleMatrix^{PQ}$ is the compatible matrix of the point $P$ and point $Q$, which equals:

<center>
$CompatibleMatrix^{PQ}=\left[ \begin{array}{c} \frac{point^P_X-point^Q_X}{length^{PQ}} & \frac{point^P_Y-point^Q_Y}{length^{PQ}} & \frac{point^P_Z-point^Q_Z}{length^{PQ}} & -\frac{point^P_X-point^Q_X}{length^{PQ}} & -\frac{point^P_Y-point^Q_Y}{length^{PQ}} & -\frac{point^P_Z-point^Q_Z}{length^{PQ}} \end{array} \right]$

</center>

</font>


<font face="Avenir Next" color="#000000" size=4 > ***Rotation Constraints*** </font>

<font face="Avenir Next" size=3> 

Apart from the distance constraints, the displacement also has to obey the rotation constraint, which means that the rotation has to happen in the specified plane in the local system. So the displacement of the $SlavePoint$ should be normal to the $VecRota$ locally. 

At an infinitesimal $\vec{\alpha}$, the global point A and point S after the displacement are:

<center>

$Point A'^{g}=Point A^{g}+d_m^{A}\cdot \alpha+\alpha^T\cdot d_c^{A}\cdot \alpha$

$Point S'^{g}=Point S^{g}+d_m^{S}\cdot \alpha+\alpha^T\cdot d_c^{S}\cdot \alpha$
</center>
And transform them into a local formation:

<center>
$Point A'^{l}=M_{AS}^{-1}\cdot (Point A'^{g}-O_{AS})=Point A^{l}+M_{AS}^{-1}\cdot d_m^{A}\cdot \alpha+\alpha^T\cdot M_{AS}^{-1}\cdot d_c^{A}\cdot \alpha$

$Point S'^{l}=M_{AS}^{-1}\cdot (Point S'^{g}-O_{AS})=Point S^{l}+M_{AS}^{-1}\cdot d_m^{S}\cdot \alpha+\alpha^T\cdot M_{AS}^{-1}\cdot d_c^{S}\cdot \alpha$
</center>

where the $M_{AS}$ is the rotation matrix of $point A$ and $point S$ in the local system. Therefore the rotation constraints can be put as:

$eqn3\rightarrow 0==VecRota\cdot (Point A'^{l}-Point S'^{l})$
$=VecRota\cdot (Point A^{l}-Point S^{l})+VecRota\cdot M_{AS}^{-1}\cdot (d_m^{A}-d_m^{S})\cdot \alpha+\alpha^T\cdot VecRota\cdot M_{AS}^{-1}\cdot (d_c^{A}-d_c^{S})\cdot \alpha$

If the $eqn3$ can be satisfied for any $\alpha$ vector, these condition shoule be met:

<center>
$eqn3.1 \rightarrow VecRota\cdot M_{AS}^{-1}\cdot (d_m^{A}-d_m^{S})=\vec{0}$

$eqn3.2 \rightarrow VecRota\cdot M_{AS}^{-1}\cdot (d_c^{A}-d_c^{S})=\vec{0}$
</center>

</font>


<font face="Avenir Next" color="#000000" size=4 > ***Solving the Equations*** </font>

<font face="Avenir Next" size=3> 


Take the $eqn1.1$, $eqn1.2$ and $eqn3.1$ to solve the $d_m^{S}$ and the result is:

<center>
$d_m^S=\left( \begin{array}{c} CompatibleMatrix^{AS}(1:3) \\ CompatibleMatrix^{BS}(1:3) \\VecRota\cdot M^{-1}_{AS} \end{array} \right)^{-1} \cdot \left( \begin{array}{c} CompatibleMatrix^{AS}(1:3)\cdot d_m^A \\ CompatibleMatrix^{BS}(1:3)\cdot d_m^B \\VecRota\cdot M^{-1}_{AS}\cdot d_m^A \end{array} \right)$

</center>

With the value $d_m^S$ and the $eqn2.1$, $eqn2.2$ and $eqn3.2$, $d_c^{S}$ can be solved. Note that the calculation of the 2nd displacement need to be treated carefully and take care of each column as the paper <a href="https://doi.org/10.1016/j.jmps.2019.103772">*A Theory for the Design of Multi-Stable Morphing Structures*</a> told. A `reshpe` order should be taken to transform it into a $3\times 6\times 6$ dimension.

<center>
$(d_c^S)_{[3\times 36]}=\left( \begin{array}{c} CompatibleMatrix^{AS}(1:3) \\ CompatibleMatrix^{BS}(1:3) \\VecRota\cdot M^{-1}_{AS} \end{array} \right)^{-1} \cdot \left( \begin{array}{c} reshape(CompatibleMatrix^{AS}(1:3)\cdot d_c^A+\frac{d_m^{AS,T}\cdot \widetilde{H}\cdot d_m^{AS}}{2\cdot length^{AS}},[1,36]) \\ reshape(CompatibleMatrix^{BS}(1:3)\cdot d_c^B+\frac{d_m^{BS,T}\cdot \widetilde{H}\cdot d_m^{BS}}{2\cdot length^{BS}},[1,36]) \\reshape(VecRota\cdot M^{-1}_{AS},[1,36]) \end{array} \right)$

</center>

</font>
---------