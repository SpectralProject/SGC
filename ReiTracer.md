## Spectral ReiTrace

A RT scheme that uses a specialised RT ASIC.

- kind of like if RT cores were its own unit + its own cache + shared memory with the CPU and GPU

## RT ISA

The ISA is quite simple since RT itself is quite simple. We just have to ensure that we have the right information ready.

- A BVH (can be generated via terraformer3d) for your map. Usually you would load each portion of your map just in time to the unified memory
- 

## BVH Algorithms

A big thing with RT is using BVH. We construct a BVH based on the locations and bounding boxes of each individual object (usually a GameModel).

```rust
// -------
//  CONSTRUCTION
// -------

fn construct_bvh() {
    // bound all the objects in a single aabb
    // basically max x/y/z for all object (coords + sizes)
    let bounding_box = AABB(objects)

    let root_node = recurse_bvh(bounding_box)

    return root_node
}

// given a bvh node (aabb box), split it in two and keep going until at most 2 elements are in the box
fn recurse_bvh(box) -> BvhNode {
    if (box.size <= 2) return

    // find longest axis of the bounding box
    // either x,y,z
    let longest_axis = bounding_box.longest_axis

    let midpoint = longest_axis.midpoint

    // split the box down near this plane, ensuring box sides are both bounded/equally spaced down the plane
    // this is the scene
    let [box1, box2] = bounding_box.split(point=midpoint, axis=longest_axis)

    // recurse
    return BvhNode(recurse(box1), recurse(box2))
}

// -------
//  TRAVERSAL
// -------

let bvh = construct_bvh()
// usually, construct an empty list for each object
// let collision_list = CollisionList()


// GENERAL ALGORITHM: find all collisions between node and any other object
// bvh is the complete list. &node is the actual reference to a specific node
// we want to get a list of any potential collisions, so any overlapping bounding boxes
fn traverse(&collision_list, &query_box, query_obj_index, &node) {
    if overlap(bvh.aabb(node), query_box) {
        if bvh.leaf(): collision_list.add(query_obj_index, bvh.index(node))

        else {
            child_l = bvh.left(node)
            child_r = bvh.right(node)

            traverse(collision_list, query_box, query_obj_index, child_l)
            traverse(collision_list, query_box, query_obj_index, child_r)
        }

    }
}

// naive way: treat the ray as a single line that spans the entire bvh box
// to get all pairs of things that it collides with
// and get the closest one

// next step: retrieve that node's GameModel material properties
// based on hit location. Then spawn another ray and repeat the above
// combine the recursed rays color values with this one
// return it

// RT ALGORITHM: for each ray, query bvh
// you have a source (x,y,z) and a direction. So the first thing that it collides with should be returned
fn check_collision(&current_node, &collision_list, &ray) -> &Node {
    // traverse the bvh from root to leaf
    recurse(current_node, collision_list)

    // return the leaf node if hit
}

check_collision(bvh, collision_list, ray)
// if hit, reflect/refract based on that material



// take the leaf node closest to the ray source


// optimisations: minimise divergence, grouping nearby objects into one so we dont duplicate traversal -> also good for parallel. But prob best is independent traversal

```


