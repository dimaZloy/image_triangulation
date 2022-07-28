

using Images, SparseArrays, VoronoiDelaunay, StatsBase, Plots, ImageView
using Statistics
using ImageBinarization
using CPUTime


# Perform image triangulation based on the paper 'Stylized Image Triangulation' by Kai Lawonn and Tobias Günther. 
# The paper can be found [here](https://cgl.ethz.ch/Downloads/Publications/Papers/2018/Law18a/Law18a.pdf) 
# and the original code can be found [here](https://github.com/tobguent/image-triangulation). 


include("sujoy.jl")
include("triangleaux.jl")
include("partData1D.jl")



function main(imgsrc::String, imgres::String, n_steps::Int)
	
	display("doing image triangulation ... ") 
	display("Number of threads = "*string(Threads.nthreads())) 

	display("load image ...");
	CPUtic();
	im = load(imgsrc)
	CPUtoc();

	height, width = size(im)

	display("width: "*string(width) )
	display("height: "*string(height) )

	im_rgb = real.(channelview(im))
	#im_gray = gray.(float(Gray.(im)))
	
	step_size = 4.
	#n_steps = 10; ## 73
	λ = 0.01 # regularization size
	τ = 0.01 # error threshold to split triangle
	split_every = 5 # split triangles every ... steps
	min_triangle_size = 1/50 * min(height, width) # only split triangle if not too small
	max_triangle_stretchedness = 6. # don't want too narrow triangles
	max_n_triangles = 100000 # stop splitting if reached
	
	display("Generate initial grid ... ")
	CPUtic();
	# points, triangles = generate_importance_grid(im_gray, width, height, 20)
	points, triangles = generate_regular_grid(width, height, 20, 20)
 	neighbors, neighbor_start_index, n_neighbors = generate_neighbors_lists(points, triangles)
	CPUtoc();
	
	display("Perform gradient descent...")
	CPUtic();
	# points, triangles = gradient_descent(points, triangles, neighbors,
	# 									 neighbor_start_index, n_neighbors,
	# 									 im_rgb, width, height,
	# 									 n_steps, step_size, λ, τ, split_every,
	# 									 max_n_triangles, min_triangle_size,
	# 									 max_triangle_stretchedness)

	points, triangles = gradientDescentThreads(points, triangles, neighbors,
										 neighbor_start_index, n_neighbors,
										 im_rgb, width, height,
										 n_steps, step_size, λ, τ, split_every,
										 max_n_triangles, min_triangle_size,
										 max_triangle_stretchedness)


	CPUtoc();


	display("Draw output image...")
	CPUtic();
	img = draw_image(triangles, points, im_rgb, width, height);
	CPUtoc();
	
	ImageView.imshow(im)
	ImageView.imshow(img)

	save(imgres, img) 
	#savefig(imgres*"_fig.png")

end
	

main("test.jpg", "test_tri.jpg",100)