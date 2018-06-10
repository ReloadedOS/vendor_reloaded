package android
type Product_variables struct {
	Target_process_sdk_version_override struct {
		Cppflags []string
	}
	Target_shim_libs struct {
		Cppflags []string
	}
	Target_uses_color_metadata struct {
		Cppflags []string
	}
	Uses_qti_camera_device struct {
		Cppflags []string
		Shared_libs []string
	}
}

type ProductVariables struct {
	Target_process_sdk_version_override *string `json:",omitempty"`
	Target_shim_libs  *string `json:",omitempty"`
	Target_uses_color_metadata  *bool `json:",omitempty"`
 	Uses_qti_camera_device  *bool `json:",omitempty"`
}
