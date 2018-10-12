#¿¿¿¿¿¿

delete dcm_patient from dcm_patient,dcm_study where dcm_study.patient_id=dcm_patient.id and dcm_study.id =2374;
delete from dcm_study where id =2374;
delete from dcm_series where study_id = 2374;
delete  file from file,dcm_instance where file.id = dcm_instance.file_id  and dcm_instance.study_id=2374;
delete  file from file,dcm_instance where file.id = dcm_instance.jpeg_file_id  and dcm_instance.study_id=2374;
delete from dcm_instance where study_id = 2374;

delete viewer_rs_roiplane from  viewer_rs_roiplane,viewer_rs where viewer_rs_roiplane.rs_id =viewer_rs.id and viewer_rs.study_id=2374;
DELETE viewer_rs_roiplane_mpr from viewer_rs_roiplane_mpr,viewer_rs where viewer_rs_roiplane_mpr.rs_id =viewer_rs.id and viewer_rs.study_id=2374;
delete  from viewer_rs_roiplane_sharding where viewer_rs_roiplane_sharding.study_id = 2374;
delete from viewer_rs where viewer_rs.study_id = 2374;

delete dcm_rd_grid_frame_file from dcm_rd,dcm_rd_grid,dcm_rd_grid_frame_file where dcm_rd_grid.rd_id = dcm_rd.id and dcm_rd_grid_frame_file.rd_grid_id = dcm_rd_grid.id and dcm_rd.id=dcm_rd.study_id=2374;
delete dcm_rd_dvh from dcm_rd_dvh,dcm_rd where dcm_rd_dvh.rd_id =dcm_rd.id and dcm_rd.study_id=2374;
delete dcm_rd_grid from dcm_rd_grid,dcm_rd where dcm_rd_grid.rd_id = dcm_rd.id and dcm_rd.study_id =2374;
delete from dcm_rd where dcm_rd.study_id = 2374;

delete dcm_rp_beam from dcm_rp_beam,dcm_rp where dcm_rp_beam.rp_id=dcm_rp.id  and dcm_rp.study_id=2374;
DELETE dcm_rp_beam_control_point from dcm_rp_beam_control_point,dcm_rp where dcm_rp_beam_control_point.rp_id = dcm_rp.id and dcm_rp.study_id=2374;
delete dcm_rp_beam_control_point_limiting_position from dcm_rp_beam_control_point_limiting_position,dcm_rp where dcm_rp_beam_control_point_limiting_position.rp_id=dcm_rp.id and dcm_rp.study_id=2374;
delete dcm_rp_beam_limiting from dcm_rp_beam_limiting,dcm_rp where dcm_rp_beam_limiting.rp_id = dcm_rp.id and dcm_rp.study_id = 2374;
DELETE dcm_rp_fraction from dcm_rp_fraction,dcm_rp where dcm_rp_fraction.rp_id = dcm_rp.id and dcm_rp.study_id = 2374;
DELETE dcm_rp_prescription from dcm_rp_prescription,dcm_rp where dcm_rp_prescription.rp_id=dcm_rp.id and dcm_rp.study_id = 2374;
delete dcm_rp_setup from dcm_rp_setup,dcm_rp where dcm_rp_setup.rp_id = dcm_rp.id and dcm_rp.study_id=2374;
delete from dcm_rp where dcm_rp.study_id=2374;
