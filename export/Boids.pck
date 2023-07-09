GDPC                 @                                                                         T   res://.godot/exported/133200997/export-77003ca56cee0e887480d89fc1977ab4-boid_2d.scn �      I      N*�������к}	    T   res://.godot/exported/133200997/export-f485c7baa029bf9321cce344dcfe91d8-flock_2d.scn $      q      F��\�EE.���j(�    ,   res://.godot/global_script_class_cache.cfg                 ��Р�8���8~$}P�    H   res://.godot/imported/Boids.png-0d9fbe3124968fef67ec80c5eee1a002.ctex   �0             ^�p�<�O�q��    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctexpF      ^      2��r3��MgB�[79       res://.godot/uid_cache.bin  �e      �       ��|�գ��7 �0��       res://2d/boid_2d.gd �      �      '����%�^4��*�B;�       res://2d/boid_2d.tscn.remap �T      d       ���x�2/�z��\'       res://2d/flock_2d.gd�      >      �šQ��o��R��%       res://2d/flock_2d.tscn.remap U      e       aU)����z%@.&�        res://2d/gui/AlignmentVBox.gd                 �!��IvFo�mx9T        res://2d/gui/BoidSpeedVBox.gd   @            8�c"�@+L���Sqbc       res://2d/gui/CohesionVBox.gd`            5�!<8aƎ�S�!�        res://2d/gui/SeparationVBox.gd  �            ��!� �x�i�ɗv|�        res://2d/gui/VisualRangeVBox.gd �            ��g��T�wJk����'       res://icon.svg  pU      N      ]��s�9^w/�����       res://icon.svg.import   �S      �       ѳ�9�r����D       res://project.binaryPf      �      {��N���������    $   res://screenshots/Boids.png.import  �E      �       �oR�^�|���    �\C��B�q��:list=Array[Dictionary]([])
t�8�extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Alignment: " + str(value)
9�t�ӑI�����extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Boid Speed: " + str(value)
�=��G�I���Vextends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Cohesion: " + str(value)
�y�[�^gb�֣����extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Separation: " + str(value)
\O&�[�9�4��extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	_set_label_text($HSlider.value)

func _on_h_slider_value_changed(value):
	_set_label_text(value)

func _set_label_text(value):
	$Label.text = "Visual Range: " + str(value)
Fpj
�����~extends Polygon2D

const IN_BOUNDS_TURN_FACTOR: float = 0.8

var window_width: int = 0
var window_height: int = 0
var window_margin: int = 0
var speed: int = 0
var velocity: Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	# Choose a random direction to start flying into
	var angle = randf_range(0, 2 * PI)
	update_velocity(Vector2(cos(angle), sin(angle)))

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float):
	velocity *= speed * _delta
	_limit_speed()
	_update_rotation()
	_update_bounds()
	translate(velocity)

func set_inital_position(_initial_position: Vector2):
	set_position(_initial_position)

func set_speed(_speed: int):
	speed = _speed

func set_window_bounds(_window_width:int, _window_height: int, _window_margin: int):
	window_height = _window_height
	window_width = _window_width
	window_margin = _window_margin

func update_velocity(_velocity: Vector2):
	velocity += _velocity

func get_velocity():
	return velocity

func _update_rotation():
	# Update model rotation to match the flight direction
	set_rotation(velocity.angle() + deg_to_rad(90))

func _limit_speed():
	# Limit speed between a minimum and maximum
	var velocity_magnitude = velocity.length()
	var clamped_speed = max(min(velocity_magnitude, speed), max(speed - 1, 1))
	velocity = velocity / velocity_magnitude * clamped_speed
	
func _update_bounds():
	if window_margin > 0:
		_stay_within_screen_bounds()
	else:
		_navigate_to_other_side_of_screen_if_out_of_bounds()

func _stay_within_screen_bounds():
	if position.x < window_margin:
		velocity.x += IN_BOUNDS_TURN_FACTOR
	elif position.x > window_width - window_margin:
		velocity.x -= IN_BOUNDS_TURN_FACTOR
	
	if position.y < window_margin:
		velocity.y += IN_BOUNDS_TURN_FACTOR
	elif position.y > window_height - window_margin:
		velocity.y -= IN_BOUNDS_TURN_FACTOR

func _navigate_to_other_side_of_screen_if_out_of_bounds():
	if position.x > window_width:
		set_position(Vector2(0, position.y))
	elif position.x < 0:
		set_position(Vector2(window_width, position.y))
	if position.y > window_height:
		set_position(Vector2(position.x, 0))
	elif position.y < 0:
		set_position(Vector2(position.x, window_height))
qRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://2d/boid_2d.gd ��������      local://PackedScene_toees          PackedScene          	         names "      
   Polygon2D 	   position 	   rotation    scale    polygon    vertex_colors    script    	   variants       
     �C  GC   �I@
      A   A%         ?    fff?  �?���=  �?$        �?  �?  �?  �?  �?  �?  �?  �?  �?  �?  �?  �?                node_count             nodes        ��������        ����                                                  conn_count              conns               node_paths              editable_instances              version             RSRC�����&extends Node2D

# The size of the flock, i.e. the total number of boids
const FLOCK_SIZE: int = 100
# The distance from the window bounds at which boids will spawn
const BOID_SPAWN_MARGIN: int = 55
const SEPARATION_WEIGHT: float = 0.06
const ALIGNMENT_WEIGHT: float = 0.35
const COHESION_WEIGHT: float = 0.05
const STEER_WEIGHT: float = 0.005
const STEER_DISTANCE: int = 200

enum STEER_DIRECTION { TO=1, AWAY=-1, NONE=0 }

var flock = []
var flock_height_bound: int = 0
var steer_direction: STEER_DIRECTION = STEER_DIRECTION.NONE
var steer_position: Vector2 = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	var boid_scene = preload("res://2d/boid_2d.tscn")
	var size = get_window().size
	flock_height_bound = size.y - $Properties.size.y
	var max_x = size.x - BOID_SPAWN_MARGIN
	var max_y = flock_height_bound - BOID_SPAWN_MARGIN
	
	for i in range(FLOCK_SIZE):
		var boid = boid_scene.instantiate()
		var initial_x = randf_range(BOID_SPAWN_MARGIN, max_x)
		var initial_y = randf_range(BOID_SPAWN_MARGIN, max_y)
		boid.set_inital_position(Vector2(initial_x, initial_y))
		boid.set_window_bounds(max_x, max_y, BOID_SPAWN_MARGIN)
		boid.set_speed($Properties/BoidSpeed/HSlider.value)
		flock.append(boid)
		add_child(boid)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	for boid in flock:
		var separation: Vector2 = _apply_separation(boid)
		var alignment: Vector2 = _apply_alignment(boid)
		var cohesion: Vector2 = _apply_cohesion(boid)
		var steering: Vector2 = _apply_steering(boid)
		var velocity: Vector2 = separation + alignment + cohesion + steering
		
		if !velocity.is_equal_approx(Vector2.ZERO):
			boid.update_velocity(velocity)

func _input(event):
	if !event is InputEventMouseButton:
		return
		
	var mouse_event = event as InputEventMouseButton
	
	# Check if it's a click on the Properties panel
	var mouse_position: Vector2 = event.position
	if mouse_position.y >= flock_height_bound:
		return
	
	if !mouse_event.pressed:
		steer_direction = STEER_DIRECTION.NONE
		return
	
	match mouse_event.button_index:
		MOUSE_BUTTON_LEFT:
			steer_direction = STEER_DIRECTION.TO
			steer_position = mouse_position
		MOUSE_BUTTON_RIGHT:
			steer_direction = STEER_DIRECTION.AWAY
			steer_position = mouse_position

func _on_boid_speed_value_changed(speed: int):
	for boid in flock:
		boid.set_speed(speed)

func _apply_separation(boid):
	var separation = Vector2()
	
	for b in flock:
		if b == boid:
			continue
		
		var to_other = boid.position - b.position
		if to_other.length() > $Properties/VisualRange/HSlider.value:
			continue
		
		separation += to_other
	
	var separation_factor = _get_slider_percentage($Properties/Separation/HSlider)
	if separation_factor == 0:
		return Vector2()
	
	separation_factor *= SEPARATION_WEIGHT
	return separation * separation_factor

func _apply_alignment(boid):
	var avg_neighbours_velocities = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > $Properties/VisualRange/HSlider.value:
			continue
		
		avg_neighbours_velocities += b.get_velocity()
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var avg_velocity = avg_neighbours_velocities / neighbours
	var alignment_factor = _get_slider_percentage($Properties/Alignment/HSlider)
	if alignment_factor == 0:
		return Vector2()
	
	alignment_factor *= ALIGNMENT_WEIGHT
	return (avg_velocity - boid.get_velocity()) * alignment_factor

func _apply_cohesion(boid):
	var avg_neighbours_positions = Vector2()
	var neighbours = 0
	
	for b in flock:
		if b == boid:
			continue
		
		var distance = boid.position.distance_to(b.position)
		if distance > $Properties/VisualRange/HSlider.value:
			continue
		
		avg_neighbours_positions += b.position
		neighbours += 1
	
	if neighbours == 0:
		return Vector2()
	
	var center_of_mass_position = avg_neighbours_positions / neighbours
	var cohesion_factor = _get_slider_percentage($Properties/Cohesion/HSlider)
	if cohesion_factor == 0:
		return Vector2()
		
	cohesion_factor *= COHESION_WEIGHT
	return (center_of_mass_position - boid.position) * cohesion_factor
	
func _apply_steering(boid):
	var final_position: Vector2 = steer_position - boid.position
	var distance = final_position.length()
	
	if steer_direction == STEER_DIRECTION.TO && distance < STEER_DISTANCE:
		return Vector2()
	elif steer_direction == STEER_DIRECTION.AWAY && distance > STEER_DISTANCE:
		return Vector2()
	
	return steer_direction * final_position * STEER_WEIGHT

func _get_slider_percentage(slider: HSlider):
	return slider.value / slider.max_value
�dRSRC                     PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://2d/flock_2d.gd ��������   Script    res://2d/gui/SeparationVBox.gd ��������   Script    res://2d/gui/AlignmentVBox.gd ��������   Script    res://2d/gui/CohesionVBox.gd ��������   Script     res://2d/gui/VisualRangeVBox.gd ��������   Script    res://2d/gui/BoidSpeedVBox.gd ��������      local://PackedScene_3ha8s          PackedScene          	         names "         Flock2D    script    Node2D    Properties    offset_top    offset_right    offset_bottom $   theme_override_constants/separation 
   alignment    HBoxContainer    Separation    layout_mode    size_flags_vertical    VBoxContainer    HSlider    custom_minimum_size    value    Label    tooltip_text    mouse_filter    horizontal_alignment    vertical_alignment 
   Alignment 	   Cohesion    VisualRange 
   BoidSpeed 
   min_value 
   max_value    _on_h_slider_value_changed    value_changed    _on_boid_speed_value_changed    	   variants                     @D     �D     4D   2                              
     HC         pB   z   Represents by how much a boid will turn away from its neighbours.
The lower the number, the more agrresive the turn gets.             �   Represents by how much a boid will align its direction with its neighbours directions.
The lower the number, the higher the alignment gets.               HB   �   Represents the boid's approximation towards the center of mass of its neighbours.
The lower the number, the higher the approximation gets.               �A   9   The distance at which a boid is able to see other boids.               �?     pA     �@      node_count             nodes     �   ��������       ����                      	      ����                                               
   ����                                      ����      	            
                    ����                                                  ����                                      ����      	            
                    ����                                                  ����                                      ����      	                                ����                                                  ����                                      ����      	                                ����                                                  ����                                      ����      	                                            ����                                           conn_count             conns     *                                                 	                                                                                                   node_paths              editable_instances              version             RSRC'�;ћ~zK��A��GST2      �     ����                �       �  RIFF�  WEBPVP8L�  /�D� e)Hۀ����""q���6� I�/��G��nzz��*u���h�V�VS��K���T�����ٶ=���Ο%a���8 N{�;u�K)-�Kq�Tq��J��Q,8!�2��!	Y�m[���B �p�y�D�_�㶕$��=�ij'����~�_�����k�������_�����k������ �����O�?��$���_����@���������j\8�d���Z^E~�A��'��g#����|����O ����;l��&�� ���Wٯ��$���_�����c��.�$^�$���o���* ��@X'k�N~ @���'�*Y�U~;�ͻn���������|���~��0Im�v6��/�q�����Au����k��o��`&�d诂����[QtY��}B~�0Y� �RR|8���R�/����o$u�XΠ��$I�O2@���Q�f�	`����?�pp��'9x��$M?pn�v�+ ��@>�Ag�+ ��cIˢ"��LR|nf��oG<�ͻ�������ǁ��a�̪/�^���oG� �U����Y�VT.e�}��ZQ����>�X`�����2�U�#���0�R���R@%�I[���*N(>� �3��e0�+����r���э�"�ҲOJ"?��B�'�0SU�<�� ��$�~�n`���' ��ث���Fv�{��<#;����JzGu��O ���J0XE2To[t�y�a&��$~ �� �'��3
o�S���j7ad'��ѡ�O���w��<���ռ����w"�0�$񜂡Jb���ͩW��b��$�k$�����_�����`?� R�I�l��rʷ��rUߎ�'���'�R.|�WS�?9������_��������د�0 �s6�G
��P�\w8k�\=Ԭ��q������^��뭎��C�@�NB�ď2�{� �Mge@��, ?��_���?��?o�Q��ʫ@%ᢳ���m�aLN3`��x��P�f��_Y��[���5JiG���)`�y�7�F|�?y��t��e2��l������a��x��	>����&��ǲ��/���>(��#��|��*�)�U]$1+ŲN:qu��o�T�j�`0�brnm[�§���?I��B�6?�hN�Sm�R����DZ���`�.'�'�&�o�a����,�D��8 Cz��3 �@W�	��q4���o�d�|��!�*]2�|A敺0'��;��X�p߼k ���������.,� ��O�'y����^�������I����zI ����0��L)�0M,2�@� �����KƸ�E��P���� 7�� ~� ݾ�*�q��Ir�p���첕m�����?�SP�|�P����O2`��}����cQ߼C���"?�<�@} ���l �������of0�<ά�y3�y̉��o���8�r&��\i�8��Sh�Ԑq2�\�$����N��?�u������?� P&�e]Kd3��r�U������5m�jU��,�ԉdU�PD� ���'���X����$��,,u -��8�T@us@;z�ܯF���=ߊ�p��_L������2ǧ�UY���]�X�vu��b��&�,#y��6�X�b2�6�%���{U�"�v�a�uٖYQ���v������"s��0��u86�����h��jq6�3�)*�j4�P���dr���,׳���}�= �cq_��?�����\�Ϫw��nm�#<8p_�����9f�Ȫ��6'�g��e���IOR��}`s`w��q���M����ᒌ����9���%��ͅ���>7�2w�p�+M��R���w\T;F2�3 �I�'Y$PX���,X���O�I�'���_�����k�������_�����k�������_�����k�������_�����k�������_�����e�-�o�����J����2}�"������(9�D�B�2�.��
	�=�D�e�B��2�E��L��YRFDթ��������Z8�D��׏��*o�'�ѩ��"%D5%���#��i_{dգ���&����S��0��SP��ի�6����bN<����^����������ƥ벯�EՊQ�Ͼۯ^��@�"N<����^��Փ�<����ŧ=�xu���EuA�>%y(x%��x���"��"*D�$>�᪮�����\T`7Ʀ&}�A��M<£��^�����<��<��z��Aę�{�9�]��+:tE�����[��.�&�"':Nt,���Xt<�1��(
|�����f�$�����#�]��<�ȍN�)!�)��	7�|�ZYu�kz�~,Mjw��G�vD��Z�K�p��_z9������J%�;��IQ&��b�	��߻��e�-���!���>*\Z��y��_���I�vm���+�ܬ�aP��X,b~z��K�a�S���ƫˮ����<�n��y�*��5E�=���m`�<��3]���	 ����; �u*QA2�ޱA���!�2�,�R����>�M��F��t7=��ϻs¢�棥�Ye����Wo`��|���Ľ����Y%w��+��d���'lP������A��rU�����鄢Ҿ�����p~��um�$ο�@O�^ �uj�}�1��$�b�X,E��k�{���IŲ���U�/���V�r�keh؆��QA�B���L�ÂIZp�ڀ�A�X��ي�����YȚ�y�*v����7�3�����M=�:�M�N�� 
�(�uj�-����!�x��f��R4���a�b��.����m�M����灑�ko�G�Ӂ2�Wz��v��;ٕ��^��'������@�k�S�Hupv� %��1VpOk��}�Û"�Mס�3$�6������rX\=��{t �:v��I���M�	��kDC�xhS�f�"�Q�z^�`�;���P/Mwͽ��������i@w4z'�3I�ML(*��`2�F�����h[.���ǻ�|�#�p���c�-
�N�j?�$keӵ�#�e_�'¬S�ƽT$�65}�,K,�"oC�+8�0�+mG�0f�f�W���$	j����p�-�\�q��i}5����9�Z�}�--�l�=�O�G��T�>�5����<��D�~c��Z�8�sp�jR����t�A[��+���@�i�������m��Ҡ�V�qi��;���c�OC�����2�u�ޙxT��W��>֫+85A��buX������$����롪�+y(e���.��r?�^�x�j����c
x.��f�5[���Y����^�C�2�:���rr<Q�@&M��b��R���?[1ʆ9]i;n�g�Ӿ1���rz�y�����_V���>���!�O�T�/���6�0| �5�@g��k�+@:_��S?�l����C7+����U�K�f.�tֆ���!2L'@s�p�g �l&��MҠ�>�-2��,#��L�Sx)nV-�V�sX�W�t�c6 �>7�g�`�,�g$��VIi�c�f�������e��Jj�>����=��F2ہ|^�N�����p0K2�T�-�3�l���C{��R�\�$�Jҕ��#<ʿrL� 9���ş��N|Ú���V�6��g<�ֻ!2�p��+C3!�ro� ̹/09I]����i7����-��t�X'Uύ@��`�p�� x�l`/o`-��t�'$A���c����1٤*6NC`�;� ���t*�7�n1���p��,�\LʊM?��SU���L|j��bz.��R�;5������,��Ҁ-lD���.���ҚX&�uJ�y���/Re$8"�=���b)
� ���te�8�D Sc�V٭��^��S�PF�r��u&���k�70�pJ�Yoݳ�W+�~�.ϐm�xdαRx��O
X��j*N��y�'04JYjAW���U.	�Z���u�z�_�]�;�:Ex�"���B��tm?{�-53Ox1:��9��ha��Ү�"����0gok&=��<�s��䆪�Y��4.��6A{��M�����*w�7�N9_g����<k8�����	���d������e@�츂�L.�#?\��� ���] \����ـZ+�L�ܳl�t���j��/��5�x����'���N������u�.кp�s�%+�E���X����������4] �tZ�عOv�2G�,PU�[X��3h{_�q7ÆV�NZ�GҨw,�d�-r��LW��]UY�:�8�F�:�� ����^��a�,]Y;2���3M�ҳI�31�S�_2Ty�N6[u��GC���p�U��
�5�5���/l���)�Av���Vw����2i�7�S��׌��]�t �3���FQ��n<���U���h��ͩw��Ɗ7m��l���d$i��H�MWV�î�^��,�y��l���[�fk8���d�'73�y�J��.��j�)�޶l���,�Z����k$�J۱�� y�׭ �Y��P����a�W���q��5l����H��޼�qK���?���&_�ڣ7��y���"j�y��>�'�C5��|�6L�����߹qT�(uOue����@M��b�	lCl<_7�N�j���nv@UU�`����9��4�1GE�o�@{��U��)s�i��:��W���/��fm��;yC�u��	�����<�1Ә���ݩ�)C:]?p������2%�N)��;�C��y��8K,�"���^(�A���s�@�}|jLx�ȃ[�},�Z��;��-� ��?��/	��,�>  ���Df����_��m����m������\��	�uz�?t.Xq�C�����L�a��D�K���Q����W�I�+�:}�T��SgUo�������{�Iʢ=��M���;�t�x��mR�-w�ua��9�ؚ7~�wPW�[���A������]y�!�v�����9��O���$���$��B6]�'�7�{t�Y������lX7Pj�o�.�%K��u���0�+mG�?&|O�hp�k/��0`��ѻR';WA[�Ƨ���!�,���;����`c��" �s����¾�A��v���-���ԡ�y����=r��ם��v<�Mt�'�+.���J,�}�S��[�߲�����e��}2j�-�>穧=�v���475>�ܪ�N565���w>z[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://qfx5lnou3wt3"
path="res://.godot/imported/Boids.png-0d9fbe3124968fef67ec80c5eee1a002.ctex"
metadata={
"vram_texture": false
}
 ��(|\ �;�f����GST2   �   �      ����               � �        &  RIFF  WEBPVP8L  /������!"2�H�l�m�l�H�Q/H^��޷������d��g�(9�$E�Z��ߓ���'3���ض�U�j��$�՜ʝI۶c��3� [���5v�ɶ�=�Ԯ�m���mG�����j�m�m�_�XV����r*snZ'eS�����]n�w�Z:G9�>B�m�It��R#�^�6��($Ɓm+q�h��6�4mb�h3O���$E�s����A*DV�:#�)��)�X/�x�>@\�0|�q��m֋�d�0ψ�t�!&����P2Z�z��QF+9ʿ�d0��VɬF�F� ���A�����j4BUHp�AI�r��ِ���27ݵ<�=g��9�1�e"e�{�(�(m�`Ec\]�%��nkFC��d���7<�
V�Lĩ>���Qo�<`�M�$x���jD�BfY3�37�W��%�ݠ�5�Au����WpeU+.v�mj��%' ��ħp�6S�� q��M�׌F�n��w�$$�VI��o�l��m)��Du!SZ��V@9ד]��b=�P3�D��bSU�9�B���zQmY�M~�M<��Er�8��F)�?@`�:7�=��1I]�������3�٭!'��Jn�GS���0&��;�bE�
�
5[I��=i�/��%�̘@�YYL���J�kKvX���S���	�ڊW_�溶�R���S��I��`��?֩�Z�T^]1��VsU#f���i��1�Ivh!9+�VZ�Mr�טP�~|"/���IK
g`��MK�����|CҴ�ZQs���fvƄ0e�NN�F-���FNG)��W�2�JN	��������ܕ����2
�~�y#cB���1�YϮ�h�9����m������v��`g����]1�)�F�^^]Rץ�f��Tk� s�SP�7L�_Y�x�ŤiC�X]��r�>e:	{Sm�ĒT��ubN����k�Yb�;��Eߝ�m�Us�q��1�(\�����Ӈ�b(�7�"�Yme�WY!-)�L���L�6ie��@�Z3D\?��\W�c"e���4��AǘH���L�`L�M��G$𩫅�W���FY�gL$NI�'������I]�r��ܜ��`W<ߛe6ߛ�I>v���W�!a��������M3���IV��]�yhBҴFlr�!8Մ�^Ҷ�㒸5����I#�I�ڦ���P2R���(�r�a߰z����G~����w�=C�2������C��{�hWl%��и���O������;0*��`��U��R��vw�� (7�T#�Ƨ�o7�
�xk͍\dq3a��	x p�ȥ�3>Wc�� �	��7�kI��9F}�ID
�B���
��v<�vjQ�:a�J�5L&�F�{l��Rh����I��F�鳁P�Nc�w:17��f}u}�Κu@��`� @�������8@`�
�1 ��j#`[�)�8`���vh�p� P���׷�>����"@<�����sv� ����"�Q@,�A��P8��dp{�B��r��X��3��n$�^ ��������^B9��n����0T�m�2�ka9!�2!���]
?p ZA$\S��~B�O ��;��-|��
{�V��:���o��D��D0\R��k����8��!�I�-���-<��/<JhN��W�1���(�#2:E(*�H���{��>��&!��$| �~�+\#��8�> �H??�	E#��VY���t7���> 6�"�&ZJ��p�C_j����	P:�~�G0 �J��$�M���@�Q��Yz��i��~q�1?�c��Bߝϟ�n�*������8j������p���ox���"w���r�yvz U\F8��<E��xz�i���qi����ȴ�ݷ-r`\�6����Y��q^�Lx�9���#���m����-F�F.-�a�;6��lE�Q��)�P�x�:-�_E�4~v��Z�����䷳�:�n��,㛵��m�=wz�Ξ;2-��[k~v��Ӹ_G�%*�i� ����{�%;����m��g�ez.3���{�����Kv���s �fZ!:� 4W��޵D��U��
(t}�]5�ݫ߉�~|z��أ�#%���ѝ܏x�D4�4^_�1�g���<��!����t�oV�lm�s(EK͕��K�����n���Ӌ���&�̝M�&rs�0��q��Z��GUo�]'G�X�E����;����=Ɲ�f��_0�ߝfw�!E����A[;���ڕ�^�W"���s5֚?�=�+9@��j������b���VZ^�ltp��f+����Z�6��j�`�L��Za�I��N�0W���Z����:g��WWjs�#�Y��"�k5m�_���sh\���F%p䬵�6������\h2lNs�V��#�t�� }�K���Kvzs�>9>�l�+�>��^�n����~Ěg���e~%�w6ɓ������y��h�DC���b�KG-�d��__'0�{�7����&��yFD�2j~�����ټ�_��0�#��y�9��P�?���������f�fj6͙��r�V�K�{[ͮ�;4)O/��az{�<><__����G����[�0���v��G?e��������:���١I���z�M�Wۋ�x���������u�/��]1=��s��E&�q�l�-P3�{�vI�}��f��}�~��r�r�k�8�{���υ����O�֌ӹ�/�>�}�t	��|���Úq&���ݟW����ᓟwk�9���c̊l��Ui�̸z��f��i���_�j�S-|��w�J�<LծT��-9�����I�®�6 *3��y�[�.Ԗ�K��J���<�ݿ��-t�J���E�63���1R��}Ғbꨝט�l?�#���ӴQ��.�S���U
v�&�3�&O���0�9-�O�kK��V_gn��k��U_k˂�4�9�v�I�:;�w&��Q�ҍ�
��fG��B��-����ÇpNk�sZM�s���*��g8��-���V`b����H���
3cU'0hR
�w�XŁ�K݊�MV]�} o�w�tJJ���$꜁x$��l$>�F�EF�޺�G�j�#�G�t�bjj�F�б��q:�`O�4�y�8`Av<�x`��&I[��'A�˚�5��KAn��jx ��=Kn@��t����)�9��=�ݷ�tI��d\�M�j�B�${��G����VX�V6��f�#��V�wk ��W�8�	����lCDZ���ϖ@���X��x�W�Utq�ii�D($�X��Z'8Ay@�s�<�x͡�PU"rB�Q�_�Q6  ��[remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://gwogqilnfhfy"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
 [remap]

path="res://.godot/exported/133200997/export-77003ca56cee0e887480d89fc1977ab4-boid_2d.scn"
~��w#x��[remap]

path="res://.godot/exported/133200997/export-f485c7baa029bf9321cce344dcfe91d8-flock_2d.scn"
��&�L-�C*<svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><g transform="translate(32 32)"><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99z" fill="#363d52"/><path d="m-16-32c-8.86 0-16 7.13-16 15.99v95.98c0 8.86 7.13 15.99 16 15.99h96c8.86 0 16-7.13 16-15.99v-95.98c0-8.85-7.14-15.99-16-15.99zm0 4h96c6.64 0 12 5.35 12 11.99v95.98c0 6.64-5.35 11.99-12 11.99h-96c-6.64 0-12-5.35-12-11.99v-95.98c0-6.64 5.36-11.99 12-11.99z" fill-opacity=".4"/></g><g stroke-width="9.92746" transform="matrix(.10073078 0 0 .10073078 12.425923 2.256365)"><path d="m0 0s-.325 1.994-.515 1.976l-36.182-3.491c-2.879-.278-5.115-2.574-5.317-5.459l-.994-14.247-27.992-1.997-1.904 12.912c-.424 2.872-2.932 5.037-5.835 5.037h-38.188c-2.902 0-5.41-2.165-5.834-5.037l-1.905-12.912-27.992 1.997-.994 14.247c-.202 2.886-2.438 5.182-5.317 5.46l-36.2 3.49c-.187.018-.324-1.978-.511-1.978l-.049-7.83 30.658-4.944 1.004-14.374c.203-2.91 2.551-5.263 5.463-5.472l38.551-2.75c.146-.01.29-.016.434-.016 2.897 0 5.401 2.166 5.825 5.038l1.959 13.286h28.005l1.959-13.286c.423-2.871 2.93-5.037 5.831-5.037.142 0 .284.005.423.015l38.556 2.75c2.911.209 5.26 2.562 5.463 5.472l1.003 14.374 30.645 4.966z" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 919.24059 771.67186)"/><path d="m0 0v-47.514-6.035-5.492c.108-.001.216-.005.323-.015l36.196-3.49c1.896-.183 3.382-1.709 3.514-3.609l1.116-15.978 31.574-2.253 2.175 14.747c.282 1.912 1.922 3.329 3.856 3.329h38.188c1.933 0 3.573-1.417 3.855-3.329l2.175-14.747 31.575 2.253 1.115 15.978c.133 1.9 1.618 3.425 3.514 3.609l36.182 3.49c.107.01.214.014.322.015v4.711l.015.005v54.325c5.09692 6.4164715 9.92323 13.494208 13.621 19.449-5.651 9.62-12.575 18.217-19.976 26.182-6.864-3.455-13.531-7.369-19.828-11.534-3.151 3.132-6.7 5.694-10.186 8.372-3.425 2.751-7.285 4.768-10.946 7.118 1.09 8.117 1.629 16.108 1.846 24.448-9.446 4.754-19.519 7.906-29.708 10.17-4.068-6.837-7.788-14.241-11.028-21.479-3.842.642-7.702.88-11.567.926v.006c-.027 0-.052-.006-.075-.006-.024 0-.049.006-.073.006v-.006c-3.872-.046-7.729-.284-11.572-.926-3.238 7.238-6.956 14.642-11.03 21.479-10.184-2.264-20.258-5.416-29.703-10.17.216-8.34.755-16.331 1.848-24.448-3.668-2.35-7.523-4.367-10.949-7.118-3.481-2.678-7.036-5.24-10.188-8.372-6.297 4.165-12.962 8.079-19.828 11.534-7.401-7.965-14.321-16.562-19.974-26.182 4.4426579-6.973692 9.2079702-13.9828876 13.621-19.449z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 104.69892 525.90697)"/><path d="m0 0-1.121-16.063c-.135-1.936-1.675-3.477-3.611-3.616l-38.555-2.751c-.094-.007-.188-.01-.281-.01-1.916 0-3.569 1.406-3.852 3.33l-2.211 14.994h-31.459l-2.211-14.994c-.297-2.018-2.101-3.469-4.133-3.32l-38.555 2.751c-1.936.139-3.476 1.68-3.611 3.616l-1.121 16.063-32.547 3.138c.015-3.498.06-7.33.06-8.093 0-34.374 43.605-50.896 97.781-51.086h.066.067c54.176.19 97.766 16.712 97.766 51.086 0 .777.047 4.593.063 8.093z" fill="#478cbf" transform="matrix(4.162611 0 0 -4.162611 784.07144 817.24284)"/><path d="m0 0c0-12.052-9.765-21.815-21.813-21.815-12.042 0-21.81 9.763-21.81 21.815 0 12.044 9.768 21.802 21.81 21.802 12.048 0 21.813-9.758 21.813-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 389.21484 625.67104)"/><path d="m0 0c0-7.994-6.479-14.473-14.479-14.473-7.996 0-14.479 6.479-14.479 14.473s6.483 14.479 14.479 14.479c8 0 14.479-6.485 14.479-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 367.36686 631.05679)"/><path d="m0 0c-3.878 0-7.021 2.858-7.021 6.381v20.081c0 3.52 3.143 6.381 7.021 6.381s7.028-2.861 7.028-6.381v-20.081c0-3.523-3.15-6.381-7.028-6.381" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 511.99336 724.73954)"/><path d="m0 0c0-12.052 9.765-21.815 21.815-21.815 12.041 0 21.808 9.763 21.808 21.815 0 12.044-9.767 21.802-21.808 21.802-12.05 0-21.815-9.758-21.815-21.802" fill="#fff" transform="matrix(4.162611 0 0 -4.162611 634.78706 625.67104)"/><path d="m0 0c0-7.994 6.477-14.473 14.471-14.473 8.002 0 14.479 6.479 14.479 14.473s-6.477 14.479-14.479 14.479c-7.994 0-14.471-6.485-14.471-14.479" fill="#414042" transform="matrix(4.162611 0 0 -4.162611 656.64056 631.05679)"/></g></svg>
P�   �^�=\   res://2d/boid_2d.tscn�>��;   res://2d/flock_2d.tscn6l�Γ|   res://icon.svg�8e-��   res://screenshots/Boids.pngS՞�с|ECFG      application/config/name         Boids      application/run/main_scene          res://2d/flock_2d.tscn     application/config/features$   "         4.0    Forward Plus       application/config/icon         res://icon.svg  "   display/window/size/viewport_width         #   display/window/size/viewport_height      �     display/window/stretch/mode         canvas_items   dotnet/project/assembly_name         Boids   U�ռx�S