

Just make it a bit faster using threads:

julia> main("test.jpg", "test_tri.jpg",200) 

<img src="https://github.com/dimaZloy/image_triangulation/blob/master/combined.jpg" alt="visualization"/>


forked from>  Image triangulation with Julia

This project conains a Pluto notebook that performs image triangulation based on the paper 
[Stylized Image Triangulation](https://onlinelibrary.wiley.com/doi/abs/10.1111/cgf.13526) by Kai Lawonn and Tobias Günther.  

Explanation can be found on https://www.basjacobs.com/post/2020-11-18-image-triangulation-with-julia/.

Perform image triangulation based on the paper 'Stylized Image Triangulation' by Kai Lawonn and Tobias Günther. 
The paper can be found [here](https://cgl.ethz.ch/Downloads/Publications/Papers/2018/Law18a/Law18a.pdf) 
and the original code can be found [here](https://github.com/tobguent/image-triangulation). 

