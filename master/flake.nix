{
  description = ''2D GPU rendering with a tiling atlas.'';

  inputs.flakeNimbleLib.owner = "riinr";
  inputs.flakeNimbleLib.ref   = "master";
  inputs.flakeNimbleLib.repo  = "nim-flakes-lib";
  inputs.flakeNimbleLib.type  = "github";
  inputs.flakeNimbleLib.inputs.nixpkgs.follows = "nixpkgs";
  
  inputs.src-boxy-master.flake = false;
  inputs.src-boxy-master.ref   = "refs/heads/master";
  inputs.src-boxy-master.owner = "treeform";
  inputs.src-boxy-master.repo  = "boxy";
  inputs.src-boxy-master.type  = "github";
  
  inputs."shady".owner = "nim-nix-pkgs";
  inputs."shady".ref   = "master";
  inputs."shady".repo  = "shady";
  inputs."shady".dir   = "0_1_3";
  inputs."shady".type  = "github";
  inputs."shady".inputs.nixpkgs.follows = "nixpkgs";
  inputs."shady".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."pixie".owner = "nim-nix-pkgs";
  inputs."pixie".ref   = "master";
  inputs."pixie".repo  = "pixie";
  inputs."pixie".dir   = "5_0_1";
  inputs."pixie".type  = "github";
  inputs."pixie".inputs.nixpkgs.follows = "nixpkgs";
  inputs."pixie".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."opengl".owner = "nim-nix-pkgs";
  inputs."opengl".ref   = "master";
  inputs."opengl".repo  = "opengl";
  inputs."opengl".dir   = "1_2_6";
  inputs."opengl".type  = "github";
  inputs."opengl".inputs.nixpkgs.follows = "nixpkgs";
  inputs."opengl".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  inputs."bitty".owner = "nim-nix-pkgs";
  inputs."bitty".ref   = "master";
  inputs."bitty".repo  = "bitty";
  inputs."bitty".dir   = "0_1_4";
  inputs."bitty".type  = "github";
  inputs."bitty".inputs.nixpkgs.follows = "nixpkgs";
  inputs."bitty".inputs.flakeNimbleLib.follows = "flakeNimbleLib";
  
  outputs = { self, nixpkgs, flakeNimbleLib, ...}@deps:
  let 
    lib  = flakeNimbleLib.lib;
    args = ["self" "nixpkgs" "flakeNimbleLib" "src-boxy-master"];
    over = if builtins.pathExists ./override.nix 
           then { override = import ./override.nix; }
           else { };
  in lib.mkRefOutput (over // {
    inherit self nixpkgs ;
    src  = deps."src-boxy-master";
    deps = builtins.removeAttrs deps args;
    meta = builtins.fromJSON (builtins.readFile ./meta.json);
  } );
}