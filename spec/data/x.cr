m = Spec::Data::FullDefault.new
#
# Get the collection for the current model.
collection : Mongo::Collection = DynFork::Globals.cache_mongo_database[
  Spec::Data::FullDefault.meta[:collection_name]]
output_data : DynFork::Globals::OutputData = m.check(pointerof(collection))
output_data.valid?.should be_true
data : BSON = output_data.data
#
data["url"].should be_nil
data["text"].should be_nil
data["phone"].should be_nil
data["password"].should be_nil
data["ip"].should be_nil
data["hash"].should be_nil
data["email"].should be_nil
data["color"].should be_nil
#
data["date"].should be_nil
data["datetime"].should be_nil
#
data["choice_text"].should be_nil
data["choice_text_mult"].should be_nil
data["choice_text_dyn"].should be_nil
data["choice_text_mult_dyn"].should be_nil
#
data["choice_i64"].should be_nil
data["choice_i64_mult"].should be_nil
data["choice_i64_dyn"].should be_nil
data["choice_i64_mult_dyn"].should be_nil
#
data["choice_f64"].should be_nil
data["choice_f64_mult"].should be_nil
data["choice_f64_dyn"].should be_nil
data["choice_f64_mult_dyn"].should be_nil
#
data["file"].should be_nil
data["image"].should be_nil
#
data["i64"].should be_nil
data["f64"].should be_nil
#
data["bool"].should be_false
